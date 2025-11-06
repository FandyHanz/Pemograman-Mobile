import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydj/Data/Jurnal.dart';
import 'package:mydj/components/media_selector.dart';
import 'package:mydj/data_provider.dart';
import 'package:provider/provider.dart';

class BuatJurnalPage extends StatefulWidget {
  BuatJurnalPage({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _BuatJurnalPageState();
  }
}

class _BuatJurnalPageState extends State<BuatJurnalPage> {
  String kelas = '';
  String mapel = '';
  int jamKe = 0;
  String tujuanPembelajaran = '';
  String kegiatanPembelajaran = '';
  String dimensiProfilPelajarPancasila = '';
  String topik = '';
  void _simpanJurnal(BuildContext context) {
    Jurnal j = Jurnal(
        kelas: this.kelas,
        mapel: this.mapel,
        jamKe: this.jamKe,
        tujuanPembelajaran: this.tujuanPembelajaran,
        kegiatanPembelajaran: this.kegiatanPembelajaran,
        dimensiProfilPelajarPancasila: this.dimensiProfilPelajarPancasila,
        topik: this.topik);
    DataProvider dp = context.read<DataProvider>();
    dp.tambahJurnal(j);
  }

  Widget _TextArea(String label, String info, String attach) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(label),
        SizedBox(
          height: 10,
        ),
        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: info,
          ),
          onChanged: (value) => {attach = value!},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title)),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kelas: '),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Masukan Kelas',
                  ),
                  onChanged: (value) => {kelas = value},
                ),
                SizedBox(height: 10),
                Text('Mapel: '),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'masukan mata pelajaran'),
                    items: [
                      DropdownMenuItem(value: 'IPA', child: Text('IPA')),
                      DropdownMenuItem(value: 'IPS', child: Text('IPS')),
                      DropdownMenuItem(value: 'BI', child: Text('BI')),
                      DropdownMenuItem(
                          value: 'MATEMATIKA', child: Text('MATEMATIKA')),
                      DropdownMenuItem(value: 'PKN', child: Text('PKN')),
                      DropdownMenuItem(
                          value: 'PENJASKES', child: Text('PENJASKES')),
                      DropdownMenuItem(
                          value: 'B.INGGRIS', child: Text('B.INGGRIS')),
                      DropdownMenuItem(
                          value: 'B.MANDARIN', child: Text('B.MANDARIN'))
                    ],
                    onChanged: (value) => {mapel = value!}),
                SizedBox(height: 10),
                Text('Jam pelajaran: '),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'masukan Jam Pelajaran'),
                    items: [
                      DropdownMenuItem(value: 1, child: Text('Satu')),
                      DropdownMenuItem(value: 2, child: Text('Dua')),
                      DropdownMenuItem(value: 3, child: Text('Tiga')),
                      DropdownMenuItem(value: 4, child: Text('Empat')),
                      DropdownMenuItem(value: 5, child: Text('Lima')),
                      DropdownMenuItem(value: 6, child: Text('Enam')),
                      DropdownMenuItem(value: 7, child: Text('Tujuh')),
                      DropdownMenuItem(value: 8, child: Text('Delapan'))
                    ],
                    onChanged: (value) => {jamKe = value!}),
                _TextArea('Tujuan Pembelajaran: ', 'Isikan Tujuan pembelajaran',
                    'tujuanPembelajaran'),
                _TextArea(
                    'Materi / Topik: ', 'Isikan topik pembelajaran', 'topik'),
                _TextArea(
                    'Kegiatan: ', 'Isikan kegiatan', 'kegiatanPembelajaran'),
                _TextArea('Dimensi Profil Pelajar Pancasila: ',
                    'Isikan dimensi profil', 'dimensiProfilPelajarPancasila'),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Foto Kegiatan'),
                SizedBox(
                  height: 10,
                ),
                MediaSelector(),
                SizedBox(height: 10),
                Text('Video Kegiatan'),
                SizedBox(height: 10),
                MediaSelector(mediaType: MediaType.video),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => {_simpanJurnal(context)},
                      child: Text('Simpan')),
                )
              ],
            ),
          ),
        ));
  }
}
