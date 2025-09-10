import 'mata_kuliah.dart';
import 'dart:io';

List<MataKuliah> transkrip = [
  MataKuliah('IF101', 'Algoritma', 3, 3.5),
  MataKuliah('IF102', 'Basis Data', 3, 4.0),
  MataKuliah('IF103', 'Pemrograman', 4, 3.0),
];
void main() {
 bool isCont = true;
 while (isCont) {
    print('Masukan opsi yang diperlukan: ');
  print('1. hitung ipk ');
  print('2. melihat nilai terbagus');
  print('3. nilai terformat');
  print('type another to exit: ');
  String? option = stdin.readLineSync();
  if (option == '1') {
    hitungNilai();
  } else if (option == '2') {
    nilaiBagus();
  } else if (option == '3') {
    nilaiTerformat();
  } else {
    isCont = false;
  }
 }
}
 void hitungNilai() {
    double totalNilai =
        transkrip.map((mk) => mk.nilai * mk.sks).reduce((a, b) => a + b);
    int totalSks = transkrip.map((mk) => mk.sks).reduce((a, b) => a + b);
    double ipk = totalNilai / totalSks;
    print('IPK: ${ipk.toStringAsFixed(2)}');
  }

  void nilaiBagus() {
    var nilaiBagus = transkrip.where((mk) => mk.nilai >= 3.5);
    print('\nMata kuliah dengan nilai bagus:');
    for (var mk in nilaiBagus) {
      print('${mk.nama} (${mk.nilai})');
    }
  }

  void nilaiTerformat() {
    print('\nDaftar Ringkas:');
    transkrip.map((mk) => '${mk.nama}: ${mk.nilai}').forEach(print);
  }
