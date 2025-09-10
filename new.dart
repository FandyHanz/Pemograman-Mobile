import 'dart:io';
import 'modul_lain.dart';
void main() {
  fungsiPercobaan();
  fungsiPercobaan2();
  fungsiPercobaan4(90);
  fungsiPercobaan5('fandy', 10);
  fungsiPercobaan6();
  fungsiPercobaanList();
  fungsiPercobaanMap();
  fungsiPercobaanSet();
}

void fungsiPercobaan() {
  String nama = 'Fandy Wahyu Hanzura';
  int umur = 19;
  double ipk = 4.00;
  bool lulus = true;
// Print
  print('Nama : $nama');
  print('Umur : $umur');
  print('IPK : $ipk');
  print('Sudah Lulus? : $lulus');
  print('--------------');
}

void fungsiPercobaan2() {
  int a = 10;
  int b = 3;
// Print perhitungan dengan operator
  print('Penjumlahan: ${a + b}');
  print('Pembagian : ${a / b}');
  print('Modulus : ${a % b}');
  print('Logika : ${(a > b) && (b < 5)}');
  print('--------------');
}

void fungsiPercobaan3() {
  stdout.write('Masukkan nama: ');
  String? nama = stdin.readLineSync();
  print('Halo, $nama!');
  print('--------------');
}

void fungsiPercobaan4(double nilai) {
  String status;
  if (nilai >= 75) {
    status = 'Lulus';
  } else {
    status = 'Mengulang';
  }
  print('Nilai : $nilai');
  print('Status: $status');
  print('--------------');
}

void fungsiPercobaan5(String nama, double jumlah) {
// Perulangan dengan for
  for (int i = 0; i < jumlah; i++) {
    print('For ke-$i: $nama');
  }
  print('--------------');
// Perulangan dengan while
  int j = 0;
  while (j < jumlah) {
    print('While ke-$j: $nama');
    j++;
  }
  print('--------------');
}
