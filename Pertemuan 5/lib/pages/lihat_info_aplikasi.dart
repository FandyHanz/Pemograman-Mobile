import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LihatInfoAplikasi extends StatefulWidget {
  LihatInfoAplikasi({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _LihatInfoAplikasi();
  }
}

class _LihatInfoAplikasi extends State<LihatInfoAplikasi> {
  final Uri _url = Uri.parse('https://fandyhanz.vercel.app');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('could not launch $_url');
    }
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('MyDJ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Aplikasi Jurnal Harian Guru',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      color: Colors.black))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Version: 0.1 (Beta)',
                  style: TextStyle(fontSize: 15, color: Colors.black))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Dibuat Oleh: ',
                  style: TextStyle(fontSize: 15, color: Colors.black))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Fandy Wahyu Hanzura',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: _launchUrl, // 2. Call your launch function here
                child: const Text(
                  // 3. This is your original Text widget
                  'FandyHanz.vercel.app',
                  style: TextStyle(
                      fontSize:
                          15, // (I kept the larger size from the last step)
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
