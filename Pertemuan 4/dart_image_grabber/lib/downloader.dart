import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class Downloader {
  static Future<String?> fetchHtml(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('Failed to load HTML. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching HTML: $e');
      return null;
    }
  }

  static Future<void> downloadImage(String imageUrl, String folderPath) async {
    try {
      final uri = Uri.parse(imageUrl);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final fileName = path.basename(uri.path);
        final filePath = path.join(folderPath, fileName);
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        print("$fileName berhasil diunduh");
      }
    } catch (e) {
      print("Gagal mengunduh gambar :$e");
    }
  }
}
