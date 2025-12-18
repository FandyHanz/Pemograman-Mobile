import os
import shutil
import cv2
import numpy as np
import mahotas
import dlib
import joblib
import uvicorn
from fastapi import FastAPI, UploadFile, File, HTTPException, Request
from fastapi.responses import JSONResponse
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
from sklearn.decomposition import PCA, IncrementalPCA
from sklearn.preprocessing import StandardScaler

# =============================================================================
# 1. KONFIGURASI SERVER
# =============================================================================
app = FastAPI(title="Age Estimation API", description="Backend Prediksi Umur Mobile")

# Izinkan akses dari HP (CORS)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Konfigurasi Folder Upload (PENTING: Agar gambar bisa diakses HP)
UPLOAD_FOLDER = "uploads"
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
# Mount folder uploads agar bisa diakses via URL http://ip:port/uploads/...
app.mount("/uploads", StaticFiles(directory=UPLOAD_FOLDER), name="uploads")

# Path File Pendukung
PATH_MODELS = "models/"
PATH_XML_FACE = "haarcascade_frontalface_alt2.xml"
PATH_DLIB_DAT = "shape_predictor_68_face_landmarks.dat"

# =============================================================================
# 2. LOAD MODELS
# =============================================================================
models = {}

def load_all_models():
    try:
        print("⏳ Sedang memuat model AI...")
        # Load Scikit-Learn Models
        models['scaler_pzm'] = joblib.load(os.path.join(PATH_MODELS, 'scaler_pzm.pkl'))
        models['scaler_aam'] = joblib.load(os.path.join(PATH_MODELS, 'scaler_aam.pkl'))
        models['scaler_bif'] = joblib.load(os.path.join(PATH_MODELS, 'scaler_bif.pkl'))
        
        models['pca_shape'] = joblib.load(os.path.join(PATH_MODELS, 'pca_shape.pkl'))
        models['ipca_app'] = joblib.load(os.path.join(PATH_MODELS, 'ipca_app.pkl'))
        models['pca_global'] = joblib.load(os.path.join(PATH_MODELS, 'pca_global.pkl'))
        
        models['mean_shape'] = np.load(os.path.join(PATH_MODELS, 'mean_shape.npy'))
        models['svm'] = joblib.load(os.path.join(PATH_MODELS, 'svm_model_final.pkl'))
        
        # Load Image Processing Models
        if not os.path.exists(PATH_XML_FACE): raise FileNotFoundError("Haarcascade not found")
        if not os.path.exists(PATH_DLIB_DAT): raise FileNotFoundError("Dlib DAT not found")

        models['cascade_face'] = cv2.CascadeClassifier(PATH_XML_FACE)
        models['dlib_detector'] = dlib.get_frontal_face_detector()
        models['dlib_predictor'] = dlib.shape_predictor(PATH_DLIB_DAT)
        
        print("✅ Semua model berhasil dimuat!")
        return True
    except Exception as e:
        print(f"❌ CRITICAL ERROR: {e}")
        return False

models_loaded = load_all_models()

AGE_LABELS = ["0-15 (Anak)", "16-25 (Remaja)", "26-35 (Dewasa)", 
              "36-45 (Dewasa Madya)", "46-60 (Paruh Baya)", "61-100 (Lansia)"]

# =============================================================================
# 3. FUNGSI PREPROCESSING & FEATURE EXTRACTION
# =============================================================================

def preprocess_image(image_path):
    """Baca gambar dari DISK (bukan bytes) agar konsisten"""
    img = cv2.imread(image_path)
    
    if img is None: return None
    
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    
    # Deteksi Wajah
    pad = 40
    gray_padded = cv2.copyMakeBorder(gray, pad, pad, pad, pad, cv2.BORDER_CONSTANT, value=[255])
    faces = models['cascade_face'].detectMultiScale(gray_padded, 1.1, 5, minSize=(30, 30))
    
    if len(faces) > 0:
        faces = sorted(faces, key=lambda x: x[2]*x[3], reverse=True)
        (x, y, w, h) = faces[0]
        face_roi = gray_padded[y:y+h, x:x+w]
    else:
        face_roi = gray_padded
        
    final_img = cv2.resize(face_roi, (128, 128), interpolation=cv2.INTER_AREA)
    final_img_norm = final_img.astype(np.float32) / 255.0
    return final_img_norm

def extract_pzm(image_norm):
    image_uint8 = (image_norm * 255).astype(np.uint8)
    try:
        return mahotas.features.zernike_moments(image_uint8, radius=60, degree=8)
    except:
        return np.zeros(25)

def extract_bif(image_norm):
    filters = []
    ksize = 31
    for theta in np.arange(0, np.pi, np.pi / 8):
        params = {'ksize':(ksize, ksize), 'sigma':4.0, 'theta':theta, 
                  'lambd':10.0, 'gamma':0.5, 'psi':0, 'ktype':cv2.CV_32F}
        kern = cv2.getGaborKernel(**params)
        kern /= 1.5 * kern.sum()
        filters.append(kern)
        
    img_float = image_norm.astype(np.float32)
    bif_features = []
    pool_size = 8
    
    for kern in filters:
        f_img = cv2.filter2D(img_float, cv2.CV_32F, kern)
        h, w = f_img.shape
        for r in range(0, h, pool_size):
            for c in range(0, w, pool_size):
                patch = f_img[r:r+pool_size, c:c+pool_size]
                if patch.size > 0: bif_features.append(np.max(patch))
                else: bif_features.append(0)
    return np.array(bif_features)

def extract_aam(image_norm):
    image_uint8 = (image_norm * 255).astype(np.uint8)
    dets = models['dlib_detector'](image_uint8, 1)
    
    n_shape = models['pca_shape'].n_components_
    n_app = models['ipca_app'].n_components_

    if len(dets) == 0:
        return np.zeros(n_shape + n_app)

    shape = models['dlib_predictor'](image_uint8, dets[0])
    pts = np.array([(shape.part(i).x, shape.part(i).y) for i in range(68)], dtype=np.float32)
    
    pts_flat = pts.reshape(1, -1)
    shape_feat = models['pca_shape'].transform(pts_flat)
    
    mean_shape = models['mean_shape']
    M, _ = cv2.estimateAffinePartial2D(pts, mean_shape)
    
    if M is not None:
        warped = cv2.warpAffine(image_uint8, M, (128, 128))
        warped_flat = warped.flatten().reshape(1, -1)
        app_feat = models['ipca_app'].transform(warped_flat)
    else:
        app_feat = np.zeros((1, n_app))
        
    return np.hstack([shape_feat, app_feat]).flatten()

# =============================================================================
# 4. API ENDPOINTS
# =============================================================================

@app.get("/")
def home():
    status = "READY" if models_loaded else "NOT READY"
    return {"message": "Server Mobile Aktif", "status": status}

@app.post("/predict")
async def predict_age(request: Request, file: UploadFile = File(...)):
    # 1. Validasi
    print(f"DEBUG: Menerima file {file.filename} tipe {file.content_type}")
    if not file.content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="File harus gambar")

    # 2. Simpan Gambar
    filename = f"upload_{file.filename}"
    file_path = os.path.join(UPLOAD_FOLDER, filename)
    
    try:
        with open(file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)
            
        # 3. Preprocessing
        processed_img = preprocess_image(file_path)
        
        if processed_img is None:
            os.remove(file_path)
            return JSONResponse({"error": "Gambar rusak/tidak terbaca"}, status_code=400)

        # 4. Feature Extraction
        feat_pzm = extract_pzm(processed_img).reshape(1, -1)
        feat_bif = extract_bif(processed_img).reshape(1, -1)
        feat_aam = extract_aam(processed_img).reshape(1, -1)
        
        feat_pzm_norm = models['scaler_pzm'].transform(feat_pzm)
        feat_bif_norm = models['scaler_bif'].transform(feat_bif)
        feat_aam_norm = models['scaler_aam'].transform(feat_aam)
        
        feat_fusion = np.hstack([feat_pzm_norm, feat_aam_norm, feat_bif_norm])
        feat_final = models['pca_global'].transform(feat_fusion)
        
        # 5. Prediksi & Probabilitas
        # Cek apakah model mendukung probabilitas langsung
        if hasattr(models['svm'], "predict_proba"):
            probs = models['svm'].predict_proba(feat_final)[0]
        else:
            # Fallback: Gunakan decision_function dan Softmax jika model tidak punya predict_proba
            d = models['svm'].decision_function(feat_final)[0]
            probs = np.exp(d) / np.sum(np.exp(d))

        pred_class = np.argmax(probs) # Ambil index dengan probabilitas tertinggi
        pred_label = AGE_LABELS[pred_class]
        confidence = float(probs[pred_class]) * 100 # Persentase keyakinan (0-100)

        # Siapkan data Histogram (List probabilitas untuk semua kelas)
        histogram_data = [float(p) * 100 for p in probs] 
        
        # 6. Buat URL Gambar
        base_url = str(request.base_url) 
        image_url = f"{base_url}uploads/{filename}"

        return JSONResponse({
            "status": "success",
            "data": {
                "prediction_label": pred_label,
                "class_id": int(pred_class),
                "confidence": round(confidence, 2), # Contoh: 85.50
                "histogram": histogram_data,        # Contoh: [10.5, 85.5, 2.0, ...]
                "image_url": image_url
            }
        })

    except Exception as e:
        import traceback
        traceback.print_exc()
        return JSONResponse({"error": "Internal Server Error", "details": str(e)}, status_code=500)
# =============================================================================
# 5. RUN SERVER
# =============================================================================
# BAGIAN INI SANGAT PENTING AGAR SERVER TIDAK LANGSUNG MATI
if __name__ == "__main__":
    print("🚀 Menjalankan Server Uvicorn...")
    uvicorn.run(app, host="0.0.0.0", port=7860)