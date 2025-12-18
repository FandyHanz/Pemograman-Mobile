# Gunakan Python versi stabil
FROM python:3.9-slim

# Install library sistem yang wajib untuk Dlib & OpenCV
RUN apt-get update && apt-get install -y \
    cmake \
    build-essential \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set folder kerja
WORKDIR /app

# Copy requirements dan install
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy semua file project ke dalam server
COPY . .

# Buat folder uploads agar tidak error
RUN mkdir -p uploads

# Buka Port 7860 (Standar Render/HF)
EXPOSE 7860

# Perintah untuk menyalakan server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860"]