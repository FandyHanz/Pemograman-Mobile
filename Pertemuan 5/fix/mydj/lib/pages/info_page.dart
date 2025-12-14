import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LihatInfoAplikasi extends StatefulWidget {
  const LihatInfoAplikasi({super.key, title});
  final String title = "Info Aplikasi";

  @override
  State<StatefulWidget> createState() {
    return _LihatInfoAplikasi();
  }
}

class _LihatInfoAplikasi extends State<LihatInfoAplikasi> {
  // final Uri _url = Uri.parse('https://fandyhanz.vercel.app');
  // Future<void> _launchUrl() async {
  //   if (!await launchUrl(_url)) {
  //     throw Exception('could not launch $_url');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Dewa-Daru',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black))
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Deteksi Wajah Dalam Rentang Umur',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      color: Colors.black))
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Version: 1.0 (Final)',
                  style: TextStyle(fontSize: 15, color: Colors.black))
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Dibuat Oleh: ',
                  style: TextStyle(fontSize: 15, color: Colors.black))
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('- Fandy Wahyu Hanzura As Back-end Application',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black))
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('- Dewita Anggraeni As Ui-Ux Application Designer',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black))
            ],
          ),

          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('- Rifqi Rizqullah As Front-end Application Designer',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black))
            ],
          ),
        ],
      )),
    );
  }
}
