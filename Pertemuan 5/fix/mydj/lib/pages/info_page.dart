import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';


class LihatInfoAplikasi extends StatefulWidget {
  const LihatInfoAplikasi({super.key});
  final String title = "Info Aplikasi";

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
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true, // Judul AppBar rata tengah
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons
                      .face_retouching_natural, // [TODO]: Ganti dengan Logo App kamu
                  size: 100,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10),
              // --- LOGO / JUDUL BESAR ---
              const Text(
                'Dewa-Daru',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color:
                      Colors.blue, // Sedikit sentuhan warna agar tidak monoton
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),

              // --- DESKRIPSI ---
              Text(
                'Deteksi Wajah Dalam Rentang Umur',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),

              // --- VERSION BADGE ---
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Version 1.0 (Final)',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),

              const SizedBox(height: 40),

              // --- BAGIAN TEAM (DIBUAT LEBIH RAPI) ---
              const Text(
                'Dibuat Oleh:',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),

              // Menggunakan Widget terpisah agar rapi
              _buildTeamMember(
                  name: 'Fandy Wahyu Hanzura',
                  role: 'Back-end Application',
                  github: 'FandyHanz'),
              _buildTeamMember(
                  name: 'Dewita Anggraini',
                  role: 'UI-UX Application Designer',
                  github: 'DewitaA12'),
              _buildTeamMember(
                  name: 'Rifqi Rizqullah',
                  role: 'Front-end Application Designer',
                  github: ''),
              SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  text: 'Link Repositori Projek Dewa-Daru',
                  style: const TextStyle( // Use const for the style
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final Uri url = Uri.parse('https://github.com/FandyHanz/Pemograman-Mobile/tree/main/Pertemuan%205/fix/mydj');
                      // Attempt to launch the URL
                      if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
                        // The URL was launched successfully
                        print('URL launched successfully: $url');
                      } else {
                        // Failed to launch the URL. Show an error message (e.g., a SnackBar)
                        print('Could not launch $url');
                        // Optional: Show a SnackBar to the user
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Gagal membuka link: $url'),
                          ),
                        );
                      }
                    },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET KHUSUS MEMBER ---
  // Ini membuat layout nama dan role menjadi tumpuk (vertikal)
  // sehingga tidak perlu pusing memikirkan indentasi kiri-kanan.
  Widget _buildTeamMember(
      {required String name, required String role, required String github}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // Jarak antar orang
      child: Column(
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4), // Jarak kecil antara Nama dan Role
          Text(
            role,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.grey[600], // Warna role lebih pudar
            ),
          ),

          const SizedBox(height: 4), // Jarak kecil antara Nama dan Role
          Text(
            github,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.grey[600], // Warna role lebih pudar
            ),
          ),
        ],
      ),
    );
  }
}
