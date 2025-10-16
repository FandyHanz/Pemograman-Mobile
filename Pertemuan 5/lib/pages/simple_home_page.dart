import 'package:flutter/material.dart';
import 'package:mydj/pages/lihat_jurnal_page.dart';

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
            builder: (context) => LihatJurnalPage(title: 'Lihat Jurnal')));
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
          Image.asset('assets/images/1.png', width: 150, height: 150),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Buat Jurnal'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  _OpenLihatJurnal(context);
                },
                child: const Text('Lihat Jurnal'),
              ),
            ],
          )
        ],
      )),
    );
  }
}
