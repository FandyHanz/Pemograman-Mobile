import json
from fastapi import FastAPI, UploadFile, File, Form
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
import os
import shutil
import uvicorn 

app = FastAPI(title="MyDJ_server", description="Server sederhana Aplikasi myDJ")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

UPLOAD_FOLDER = "uploads"
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

@app.get("/")
def root():
    return {"message": "mydj_server berjalan dengan baik!"}

@app.post("/upload-jurnal")
async def upload_jurnal(
    kelas: str = Form(...),
    mapel: str = Form(...),
    jam: int = Form(...),
    tujuanPembelajaran: str = Form(...),
    topik: str = Form(...), # You decided to use 'topik' here
    kegiatanPembelajaran: str = Form(...),
    dimensiProfilPelajarPancasila: str = Form(...),
    waktuPembuatan: str = Form(...),
    image: UploadFile | None = File(None),
    video: UploadFile | None = File(None)
):
    
    # FIX 1: Initialize the actual variables we use later
    final_image_path = None
    final_video_path = None

    # Handle Image
    if image:
        filename = image.filename.split('/')[-1] 
        # FIX 2: Assign to the variable we initialized above
        final_image_path = os.path.join(UPLOAD_FOLDER, filename)
        with open(final_image_path, "wb") as buffer:
            shutil.copyfileobj(image.file, buffer)
        
    # Handle Video
    if video:
        filename = video.filename.split('/')[-1]
        final_video_path = os.path.join(UPLOAD_FOLDER, filename)
        with open(final_video_path, "wb") as buffer:
            shutil.copyfileobj(video.file, buffer)

    jurnal_data = {
        "kelas": kelas,
        "mapel": mapel,
        "jam": jam,
        "tujuanPembelajaran": tujuanPembelajaran,
        "topik": topik, 
        "kegiatanPembelajaran": kegiatanPembelajaran,
        "dimensiProfilPelajarPancasila": dimensiProfilPelajarPancasila,
        "waktuPembuatan": waktuPembuatan,
        # FIX 3: Save the correct variable
        "image": final_image_path, 
        "video": final_video_path
    }
    
    DATA_FILE = "uploads/data.json"
    if not os.path.exists(DATA_FILE):
        with open(DATA_FILE, "w") as f:
            json.dump([], f, indent=2)
            
    try:
        with open(DATA_FILE, "r") as f:
            data = json.load(f)
    except json.JSONDecodeError:
        data = [] 
        
    data.append(jurnal_data)
    
    with open(DATA_FILE, "w") as f:
        json.dump(data, f, indent=2)
        
    return JSONResponse({
        "message": "Jurnal berhasil di-upload!",
        "data": {
            "kelas": kelas,
            "mapel": mapel,
            "jam": jam,
            "topik": topik,
            "createdAt": waktuPembuatan,
            "image_url": final_image_path,
            "video_url": final_video_path,
        }
    })

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=5000)