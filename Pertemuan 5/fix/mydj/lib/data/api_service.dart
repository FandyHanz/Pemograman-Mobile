import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // <--- Wajib Import ini

class ApiService {
  // Ganti IP sesuai Laptop kamu
  final String baseUrl = 'http://10.57.31.101:5000'; // Sesuaikan port juga

  Future<Map<String, dynamic>?> predictAge(File imageFile) async {
    try {
      var uri = Uri.parse('$baseUrl/predict');
      var request = http.MultipartRequest('POST', uri);

      // FIX: Kita definisikan manual bahwa ini adalah gambar JPEG
      // agar tidak dideteksi sebagai 'application/octet-stream'
      var multipartFile = await http.MultipartFile.fromPath(
        'file', // <-- Nama ini HARUS sama dengan di main.py (file: UploadFile)
        imageFile.path,
        contentType: MediaType('image', 'jpeg'), // <-- Ini kuncinya
      );

      request.files.add(multipartFile);

      print("Mengirim request ke $uri ...");
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("Status Code: ${response.statusCode}");
      print(
          "Response Body: ${response.body}"); // Debugging: Lihat pesan error server

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Error koneksi: $e");
      return null;
    }
  }
}
