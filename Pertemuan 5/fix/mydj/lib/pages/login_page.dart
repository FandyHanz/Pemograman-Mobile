import 'package:flutter/material.dart';
import 'package:mydj/components/password_field.dart';
import 'package:mydj/pages/simple_home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  // 1. Gunakan Controllers
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // 4. Tambahkan metode dispose
  @override
  void dispose() {
    // Bersihkan controller saat widget dibuang
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login(BuildContext context) {
    // 3. Baca nilai dari controller
    String namaPengguna = _usernameController.text;
    String sandi = _passwordController.text;

    if (namaPengguna == 'guru' && sandi == 'guru') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SimpleHomePage(title: 'Beranda'),
        ),
      );
    }
  }

  void _OpenHomePage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SimpleHomePage(title: 'MyDj')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat Datang'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/icon.png',
                  width: 200,
                  height: 200,
                ),
                Text(
                  'Log-In',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Username'),
                TextField(
                  controller: _usernameController, // 2. Pasang controller
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Username'),
                  // Hapus onChanged
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Password'),
                PasswordField(
                  controller: _passwordController, // 2. Pasang controller
                ),
                SizedBox(
                  height: 10,
                ),
                FilledButton(
                    onPressed: () {
                      login(context);
                    },
                    child: Text('Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
