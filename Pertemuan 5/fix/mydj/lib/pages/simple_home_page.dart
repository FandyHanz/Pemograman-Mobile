import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Data/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedImage;
  String? _resultLabel;
  String? _serverImageUrl;
  bool _isLoading = false;

  final ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();

  // Fungsi ambil gambar (Kamera/Galeri)
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 800, // Resize sedikit agar upload lebih cepat
      maxHeight: 800,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _resultLabel = null; // Reset hasil sebelumnya
        _serverImageUrl = null;
      });
    }
  }

  // Fungsi kirim ke backend
  Future<void> _analyzeImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
    });

    final result = await _apiService.predictAge(_selectedImage!);

    setState(() {
      _isLoading = false;
      if (result != null && result['status'] == 'success') {
        // Ambil data sesuai format JSON dari main.py
        _resultLabel = result['data']['prediction_label'];
        _serverImageUrl = result['data']['image_url'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal memprediksi. Cek koneksi server.")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prediksi Umur AI"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. AREA GAMBAR
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: _selectedImage == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, size: 80, color: Colors.grey),
                          Text("Belum ada foto dipilih"),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(_selectedImage!, fit: BoxFit.cover),
                      ),
              ),
            ),
            
            const SizedBox(height: 20),

            // 2. TOMBOL PILIH GAMBAR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Kamera"),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text("Galeri"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 3. TOMBOL PROSES
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: (_selectedImage != null && !_isLoading) ? _analyzeImage : null,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("PREDIKSI UMUR SEKARANG", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 30),

            // 4. HASIL PREDIKSI
            if (_resultLabel != null)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green),
                ),
                child: Column(
                  children: [
                    const Text("Hasil Prediksi:", style: TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 5),
                    Text(
                      _resultLabel!,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}