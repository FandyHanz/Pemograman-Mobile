import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydj/components/password_field.dart';

class LihatAkun extends StatefulWidget {
  LihatAkun({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _LihatAkun();
  }
}

class _LihatAkun extends State<LihatAkun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ganti Sandi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Text('Sandi saat ini'),
              PasswordField(),
              SizedBox(
                height: 10,
              ),
              Text('Sandi baru'),
              PasswordField(),
              SizedBox(
                height: 10,
              ),
              Text('Konfirmasi Sandi'),
              PasswordField(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
