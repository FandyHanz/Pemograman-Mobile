import 'package:flutter/material.dart';
import 'simple_home_page.dart'; // [TODO]: Pastikan import ini mengarah ke file halaman utamamu
import 'info_page.dart';
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan Stack agar bisa memberi background gambar/warna penuh
      body: Stack(
        children: [
          // 1. BACKGROUND (Bisa warna solid, gradasi, atau gambar)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blueAccent, // Warna Atas
                  Colors.lightBlueAccent, // Warna Bawah
                ],
              ),
            ),
          ),

          // 2. KONTEN (Logo, Teks, Tombol)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(), // Pendorong agar konten ada di tengah-bawah

                  // --- LOGO / GAMBAR ---
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.face_retouching_natural, // [TODO]: Ganti dengan Logo App kamu
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                  
                  const SizedBox(height: 30),

                  // --- JUDUL APLIKASI ---
                  const Text(
                    "Dewa-Daru", // [TODO]: Ganti Judul
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  // --- DESKRIPSI SINGKAT ---
                  const Text(
                    "Deteksi wajah", // [TODO]: Ganti Judul
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Text(
                    "Dalam Rentang Umur", // [TODO]: Ganti Judul
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                 
                  const Spacer(), // Spacer lagi untuk memberi jarak dengan tombol

                  // --- TOMBOL MULAI ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueAccent,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // Navigasi ke Halaman Utama (TemplateScreen)
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Mulai",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 5,),

                   SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueAccent,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // Navigasi ke Halaman Utama (TemplateScreen)
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LihatInfoAplikasi()),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Tentang Aplikasi",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20), // Jarak aman bawah
                  
                  // --- FOOTER / VERSI ---
                  const Text(
                    "Versi 1.0.0",
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}