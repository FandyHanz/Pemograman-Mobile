import 'dart:io';
import 'package:dart_image_grabber/image_grabber.dart';

void main() {
  // final url = 'https://example.com';
  // final outputFolder = 'downloaded_images';

  // final imageGrabber = ImageGrabber(url, outputFolder);
  // imageGrabber.run();

  print("Selamat datang di Image Grabber!");
  print('inputkan halaman web yang ingin di grab gambarnya:');
  String? url = stdin.readLineSync();
  print('masukan folder tujuan unduhan gambar: ');
  String? outputFolder = stdin.readLineSync();
  final imageGrabber =
      ImageGrabber(url ?? '', outputFolder ?? 'downloaded_images');
  imageGrabber.run();
}
