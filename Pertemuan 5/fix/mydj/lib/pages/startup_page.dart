import 'package:flutter/material.dart';
import 'package:mydj/data_provider.dart';
import 'package:mydj/pages/login_page.dart';
import 'package:mydj/pages/simple_home_page.dart';
import 'package:provider/provider.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StartupPageWidget();
  }
}

class _StartupPageWidget extends State<StartupPage> {
  bool ?_isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return _isLoggedIn!
        ? const SimpleHomePage(title: 'beranda')
        : const LoginPage();
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // <-- Kita akan implementasikan method ini nanti.
  }

  Future<void> _checkLoginStatus() async {
// Ambil instance state management (Provider).
    final DataProvider provider = context.read<DataProvider>();
// Panggil method pengecekan login dari instance tersebut.
    final bool isLoggedIn = await provider.isLoggedIn();
// Setelah async, pastikan widget masih ada.
    if (!mounted) return;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }
}
