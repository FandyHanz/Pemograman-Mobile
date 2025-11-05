import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  // 1. TAMBAHKAN CONTROLLER DI SINI
  final TextEditingController? controller;

  // 2. TAMBAHKAN KE KONSTRUKTOR
  const PasswordField({
    super.key,
    this.controller,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  // Untuk mengatur lihat/sembunyikan password
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      // 3. GUNAKAN CONTROLLER YANG DITERIMA DARI WIDGET
      controller: widget.controller,
      obscureText: _obscureText, // Sembunyikan teks
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
        // Tambahkan ikon mata untuk toggle password
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            // Update state untuk ganti ikon dan teks
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
