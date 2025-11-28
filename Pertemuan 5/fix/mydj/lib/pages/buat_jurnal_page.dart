import 'package:flutter/material.dart';
import 'package:mydj/Data/Jurnal.dart';
import 'package:mydj/Data/api_service.dart';
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
  // Form State Variables
  String kelas = '';
  String mapel = '';
  int jamKe = 0;
  String tujuanPembelajaran = '';
  String kegiatanPembelajaran = '';
  String dimensiProfilPelajarPancasila = '';
  String topik = '';
  String fotoKegiatanPath = '';
  String videoKegiatanPath = '';

  // 1. FIX: Added Loading Indicator logic
  bool _isLoading = false;

  void _simpanJurnal(BuildContext context) {
    // Basic Validation
    if (kelas.isEmpty || mapel.isEmpty || jamKe == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap isi Kelas, Mapel, dan Jam!")),
      );
      return;
    }

    Jurnal j = Jurnal(
        kelas: kelas,
        mapel: mapel,
        jamKe: jamKe,
        tujuanPembelajaran: tujuanPembelajaran,
        kegiatanPembelajaran: kegiatanPembelajaran,
        dimensiProfilPelajarPancasila: dimensiProfilPelajarPancasila,
        topik: topik,
        fotoKegiatanPath: fotoKegiatanPath,
        videoKegiatanPath: videoKegiatanPath);

    // Save locally
    DataProvider dp = context.read<DataProvider>();
    dp.tambahJurnal(j);

    // Upload to Server
    _uploadJurnal(context, j);
  }

  Future<void> _uploadJurnal(BuildContext context, Jurnal jurnal) async {
    // Show Loading
    setState(() {
      _isLoading = true;
    });

    // Show Loading Dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await ApiService.uploadJurnal(jurnal);

      if (context.mounted) {
        // Close Loading Dialog
        Navigator.of(context).pop();

        // Stop Loading State
        setState(() {
          _isLoading = false;
        });

        // Show Success
        await _showSuccesDialog(context);
      }
    } catch (e) {
      if (context.mounted) {
        // Close Loading Dialog
        Navigator.of(context).pop();

        setState(() {
          _isLoading = false;
        });

        // Show Error Dialog (So you know why it failed)
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Gagal Upload"),
            content: Text("Error: $e"), // Shows the actual error message
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              )
            ],
          ),
        );
      }
    }
  }

  Future<void> _showSuccesDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Berhasil"),
            content: const Text("Data Jurnal berhasil di submit"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close Dialog
                    Navigator.of(context)
                        .pop(); // Go back to previous screen (Optional)
                  },
                  child: const Text("ok"))
            ],
          );
        });
  }

  // 2. FIX: Changed structure to accept a Function(String) callback
  // Previously, passing the variable name as a string string did not update the state.
  Widget _textArea(String label, String info, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(label),
        const SizedBox(height: 10),
        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: info,
          ),
          // Connect the callback to the TextField
          onChanged: onChanged,
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
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Masukan Kelas',
                  ),
                  onChanged: (value) => setState(() => kelas = value),
                ),
                const SizedBox(height: 10),

                const Text('Mapel: '),
                const SizedBox(height: 10),
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
                    onChanged: (value) =>
                        setState(() => mapel = value.toString())),

                const SizedBox(height: 10),
                const Text('Jam pelajaran: '),
                const SizedBox(height: 10),
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
                    onChanged: (value) =>
                        setState(() => jamKe = int.parse(value.toString()))),

                // 3. FIX: Passing the setState functions correctly
                _textArea('Tujuan Pembelajaran: ', 'Isikan Tujuan pembelajaran',
                    (val) => setState(() => tujuanPembelajaran = val)),

                _textArea('Materi / Topik: ', 'Isikan topik pembelajaran',
                    (val) => setState(() => topik = val)),

                _textArea('Kegiatan: ', 'Isikan kegiatan',
                    (val) => setState(() => kegiatanPembelajaran = val)),

                _textArea(
                    'Dimensi Profil Pelajar Pancasila: ',
                    'Isikan dimensi profil',
                    (val) =>
                        setState(() => dimensiProfilPelajarPancasila = val)),

                const SizedBox(height: 10),
                const SizedBox(height: 10),

                const Text('Foto Kegiatan'),
                const SizedBox(height: 10),
                MediaSelector(
                  onMediaChanged: (mediaPath) {
                    setState(() {
                      fotoKegiatanPath = mediaPath;
                    });
                  },
                ),

                const SizedBox(height: 10),
                const Text('Video Kegiatan'),
                const SizedBox(height: 10),
                MediaSelector(
                  mediaType: MediaType.video,
                  onMediaChanged: (mediaPath) {
                    setState(() {
                      videoKegiatanPath = mediaPath;
                    });
                  },
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      // Disable button while loading to prevent double-click
                      onPressed:
                          _isLoading ? null : () => _simpanJurnal(context),
                      child: _isLoading
                          ? const Text('Mengirim...')
                          : const Text('Simpan')),
                )
              ],
            ),
          ),
        ));
  }
}
