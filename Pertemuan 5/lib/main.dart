import 'package:flutter/material.dart';
import 'package:mydj/pages/simple_home_page.dart';

void main() {
  MyDjTI3C app = const MyDjTI3C();
  runApp(app);
}

class MyDjTI3C extends StatelessWidget {
  const MyDjTI3C({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyDJ - Jurnal guru',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const SimpleHomePage(title: 'Jurnal Harian Guru'));
  }
}
