// import 'package:flutter/material.dart';
// import 'package:mydj/components/password_field.dart';
// import 'package:mydj/data_provider.dart';
// import 'package:mydj/pages/simple_home_page.dart';
// import 'package:provider/provider.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return _LoginPageState();
//   }
// }

// class _LoginPageState extends State<LoginPage> {
//   // 1. Gunakan Controllers
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();

//   // 4. Tambahkan metode dispose
//   @override
//   void dispose() {
//     // Bersihkan controller saat widget dibuang
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _login(BuildContext context) async {
//     DataProvider provider = context.read<DataProvider>();
//     // 3. Baca nilai dari controller
//     String namaPengguna = _usernameController.text;
//     String sandi = _passwordController.text;

//     if (namaPengguna == 'guru' && sandi == 'guru') {
//       await provider.saveLoginInfo(namaPengguna, sandi);
//       if (context.mounted) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const SimpleHomePage(title: 'Beranda'),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Selamat Datang'),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               children: [
//                 Image.asset(
//                   'assets/images/icon.png',
//                   width: 200,
//                   height: 200,
//                 ),
//                 const Text(
//                   'Log-In',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 50,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Text('Username'),
//                 TextField(
//                   controller: _usernameController, // 2. Pasang controller
//                   decoration: const InputDecoration(
//                       border: OutlineInputBorder(), labelText: 'Username'),
//                   // Hapus onChanged
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Text('Password'),
//                 PasswordField(
//                   controller: _passwordController, // 2. Pasang controller
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 FilledButton(
//                     onPressed: () {
//                       _login(context);
//                     },
//                     child: const Text('Login'))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
