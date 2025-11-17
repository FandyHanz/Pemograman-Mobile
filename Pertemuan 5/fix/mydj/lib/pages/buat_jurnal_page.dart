import 'package:flutter/material.dart';
import 'package:mydj/Data/Jurnal.dart';
import 'package:mydj/components/media_selector.dart';
import 'package:mydj/data_provider.dart';
import 'package:provider/provider.dart';

class BuatJurnalPage extends StatefulWidget {
  const BuatJurnalPage({super.key, required this.title});
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
        kelas: kelas,
        mapel: mapel,
        jamKe: jamKe,
        tujuanPembelajaran: tujuanPembelajaran,
        kegiatanPembelajaran: kegiatanPembelajaran,
        dimensiProfilPelajarPancasila: dimensiProfilPelajarPancasila,
        topik: topik);
    DataProvider dp = context.read<DataProvider>();
    dp.tambahJurnal(j);
  }

  Widget _TextArea(String label, String info, String attach) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(label),
        const SizedBox(
          height: 10,
        ),
        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: info,
          ),
          onChanged: (value) => {attach = value},
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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Kelas: '),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Masukan Kelas',
                  ),
                  onChanged: (value) => {kelas = value},
                ),
                const SizedBox(height: 10),
                const Text('Mapel: '),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'masukan mata pelajaran'),
                    items: const [
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
                const SizedBox(height: 10),
                const Text('Jam pelajaran: '),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'masukan Jam Pelajaran'),
                    items: const [
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
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Foto Kegiatan'),
                const SizedBox(
                  height: 10,
                ),
                const MediaSelector(),
                const SizedBox(height: 10),
                const Text('Video Kegiatan'),
                const SizedBox(height: 10),
                const MediaSelector(mediaType: MediaType.video),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => {_simpanJurnal(context)},
                      child: const Text('Simpan')),
                )
              ],
            ),
          ),
        ));
  }
}
