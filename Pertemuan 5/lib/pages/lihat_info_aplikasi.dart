import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LihatInfoAplikasi extends StatefulWidget {
  LihatInfoAplikasi({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _LihatInfoAplikasi();
  }
}

class _LihatInfoAplikasi extends State<LihatInfoAplikasi> {
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
        children: [],
      )),
    );
  }
}
