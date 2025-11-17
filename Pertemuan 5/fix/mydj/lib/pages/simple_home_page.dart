import 'package:flutter/material.dart';
import 'package:mydj/pages/lihat_info_aplikasi.dart';
import 'package:mydj/pages/lihat_jurnal_page.dart';
import 'package:mydj/pages/buat_jurnal_page.dart';
import 'package:mydj/pages/lihat_akun.dart';

class SimpleHomePage extends StatefulWidget {
  const SimpleHomePage({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _SimpleHomePageState();
  }
}

class _SimpleHomePageState extends State<SimpleHomePage> {
  void _OpenLihatJurnal(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LihatJurnalPage(title: 'Lihat Jurnal')));
  }

  void _MadeAnJurnal(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const BuatJurnalPage(title: 'Buat Jurnal')));
  }

  void _LihatAkun(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LihatAkun(title: 'Lihat akun')));
  }

  void _LihatInfoAplikasi(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const LihatInfoAplikasi(title: 'Lihat Info Aplikasi')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/2.png', width: 150, height: 150),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _MadeAnJurnal(context);
                },
                child: const Text('Buat Jurnal'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _OpenLihatJurnal(context);
                },
                child: const Text('Lihat Jurnal'),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _LihatAkun(context);
                },
                child: const Text('Akun'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  _LihatInfoAplikasi(context);
                },
                child: const Text('Tentang Aplikasi'),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
