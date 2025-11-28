import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'Jurnal.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:5000";

  static Future<void> uploadJurnal(Jurnal jurnal) async {
    final url = Uri.parse("$baseUrl/upload-jurnal");
    var request = http.MultipartRequest("POST", url);

    // -----------------------------
    // 1) Kirim field Teks
    // -----------------------------
    request.fields['kelas'] = jurnal.kelas;
    request.fields['mapel'] = jurnal.mapel;
    request.fields['jam'] = jurnal.jamKe.toString();
    request.fields['tujuanPembelajaran'] = jurnal.tujuanPembelajaran;
    request.fields['topik'] = jurnal.topik; // Check if this should be 'topik'
    request.fields['kegiatanPembelajaran'] = jurnal.kegiatanPembelajaran;
    request.fields['dimensiProfilPelajarPancasila'] = jurnal.dimensiProfilPelajarPancasila;
    request.fields['waktuPembuatan'] = jurnal.waktuPembuatan.toIso8601String();

    // -----------------------------
    // 2) Handle Image (Foto)
    // -----------------------------
    // FIX: Check null first to avoid crash
    if (jurnal.fotoKegiatanPath != null && jurnal.fotoKegiatanPath!.isNotEmpty) {
      
      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        jurnal.fotoKegiatanPath!,
        filename: File(jurnal.fotoKegiatanPath!).uri.pathSegments.last,
      );

      // Add to request
      request.files.add(multipartFile);
    }

    // -----------------------------
    // 3) Handle Video
    // -----------------------------
    if (jurnal.videoKegiatanPath != null && jurnal.videoKegiatanPath!.isNotEmpty) {
      
      var videoData = await http.MultipartFile.fromPath(
        'video',
        jurnal.videoKegiatanPath!,
        filename: File(jurnal.videoKegiatanPath!).uri.pathSegments.last,
      );

      // Add to request
      request.files.add(videoData);
    }

    // -----------------------------
    // 4) Send Request (ONCE)
    // -----------------------------
    try {
      // This is the ONLY place you should call send()
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
          "Gagal upload jurnal: ${response.statusCode}\n$responseBody",
        );
      } else {
        print("Upload sukses: $responseBody");
      }
    } catch (e) {
      // Re-throw so the UI knows it failed
      throw Exception("Connection Error: $e");
    }
  }
}