import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuatJurnalPage extends StatefulWidget {
  BuatJurnalPage({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _BuatJurnalPage();
  }
}

class _BuatJurnalPage extends State<BuatJurnalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title)),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      )),
    );
  }
}
