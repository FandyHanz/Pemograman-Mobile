import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedImage;
  String? _resultLabel;
  String? _serverImageUrl;
  double? _confidence;
  List<dynamic>? _histogramData; // Data probabilitas per kelas
  bool _isLoading = false;

  final ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();

  // Label Umur (Harus urut sesuai Python)
  final List<String> _ageLabels = [
    "0-15 (Anak)", 
    "16-25 (Remaja)", 
    "26-35 (Dewasa)", 
    "36-45 (D. Madya)", 
    "46-60 (P. Baya)", 
    "61-100 (Lansia)"
  ];

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 800, 
      maxHeight: 800,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _resultLabel = null;
        _serverImageUrl = null;
        _confidence = null;
        _histogramData = null;
      });
    }
  }

  Future<void> _analyzeImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _apiService.predictAge(_selectedImage!);

      setState(() {
        _isLoading = false;
        
        if (result != null && 
            result['status'] == 'success' && 
            result['data'] != null) {
          
          final data = result['data'];
          _resultLabel = data['prediction_label'];
          _serverImageUrl = data['image_url'];
          _confidence = data['confidence']; // Ambil nilai confidence
          _histogramData = data['histogram']; // Ambil data histogram
          
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text("Gagal: ${result?['error'] ?? 'Respons tidak valid'}")),
          );
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error Aplikasi: $e");
    }
  }

  // Widget untuk membuat bar histogram
  Widget _buildHistogram() {
    if (_histogramData == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Detail Akurasi:", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...List.generate(_ageLabels.length, (index) {
          // Ambil nilai persen, jika error set ke 0
          double percent = 0;
          if (index < _histogramData!.length) {
            percent = double.parse(_histogramData![index].toString());
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                // Label Umur
                SizedBox(
                  width: 100,
                  child: Text(
                    _ageLabels[index], 
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                // Bar Chart
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: (percent / 100).clamp(0.0, 1.0),
                        child: Container(
                          height: 15,
                          decoration: BoxDecoration(
                            color: percent > 50 ? Colors.green : Colors.blueAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Teks Persen
                SizedBox(
                  width: 45,
                  child: Text(
                    "${percent.toStringAsFixed(1)}%", 
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prediksi Umur AI"), backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // IMAGE AREA
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey[200]),
                child: _selectedImage == null
                    ? const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.image, size: 60, color: Colors.grey), Text("Pilih Foto")])
                    : ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.file(_selectedImage!, fit: BoxFit.cover)),
              ),
            ),
            const SizedBox(height: 15),

            // BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(onPressed: () => _pickImage(ImageSource.camera), icon: const Icon(Icons.camera_alt), label: const Text("Kamera")),
                ElevatedButton.icon(onPressed: () => _pickImage(ImageSource.gallery), icon: const Icon(Icons.photo_library), label: const Text("Galeri")),
              ],
            ),
            const SizedBox(height: 15),

            // PROCESS BUTTON
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
                onPressed: (_selectedImage != null && !_isLoading) ? _analyzeImage : null,
                child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("PREDIKSI UMUR", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 20),

            // RESULT AREA
            if (_resultLabel != null)
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green),
                ),
                child: Column(
                  children: [
                    const Text("Hasil Prediksi Utama:", style: TextStyle(color: Colors.grey)),
                    Text(_resultLabel!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                    Text(
                      "Confidence: ${_confidence?.toStringAsFixed(2)}%", 
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)
                    ),
                    const Divider(),
                    _buildHistogram(), // Tampilkan Grafik Batang
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}