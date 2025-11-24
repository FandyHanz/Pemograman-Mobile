import 'package:flutter/material.dart';
import 'package:mydj/Data/login_info.dart';
import 'package:mydj/components/password_field.dart';
import 'package:mydj/pages/login_page.dart';

class LihatAkun extends StatefulWidget {
  const LihatAkun({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _LihatAkun();
  }
}

class _LihatAkun extends State<LihatAkun> {
  void _OpenLoginPage(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future<void> _logout(BuildContext context) async {
    await LoginInfo.deleteFromSharedPreferences();
    _OpenLoginPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ganti Sandi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Sandi saat ini'),
                  const PasswordField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Sandi baru'),
                  const PasswordField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Konfirmasi Sandi'),
                  const PasswordField(),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity, // <-- Tambahkan ini
                    child:
                        FilledButton(onPressed: () {}, child: const Text('Simpan')),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Keluar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity, // <-- Tambahkan ini
                    child: FilledButton(
                      onPressed: () {
                        _logout(context);
                      },
                      child: const Text('Keluar dari aplikasi'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )));
  }
}
