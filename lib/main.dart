import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  // Pastikan widget Flutter udah siap sebelum Firebase jalan
  WidgetsFlutterBinding.ensureInitialized();

  // Menghubungkan aplikasi ke Firebase beserta Kunci Aksesnya
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA8M2rGRADHkqnwVkxcjZgmNZ6rdo9d-Ds",
      appId: "1:533114799646:web:4c293ab68ac36d2b5a500f",
      messagingSenderId: "533114799646",
      projectId: "test-project-flutter-2fb29",
      storageBucket: "test-project-flutter-2fb29.firebasestorage.app",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Ubah halaman awal ke TestFirebasePage untuk Praktikum 7
      home: const TestFirebasePage(),
    );
  }
}

// --- HALAMAN PRAKTIKUM 7: TES KONEKSI FIREBASE ---
class TestFirebasePage extends StatelessWidget {
  const TestFirebasePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Praktikum 7 Firebase"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder(
          // Mengambil data dari collection 'mahasiswa'
          future: firestore.collection("mahasiswa").get(),
          builder: (context, snapshot) {
            // Kalau masih loading
            if (!snapshot.hasData) {
              return const Text(
                "Loading data...",
                style: TextStyle(fontSize: 18),
              );
            }
            // Kalau sukses dan data berhasil ditarik
            return const Text(
              "Data berhasil diambil dari Firebase!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }
}

// --- ARSIP TUGAS PROFILE APP (Agar tidak hilang) ---
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Profile App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 100, bottom: 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF42A5F5), Color(0xFF1976D2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/rafif.jpeg'),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Rafif Dwi Pradipta",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Mahasiswa Bisnis Digital",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Text("Halaman Profil Kamu Tersimpan di Sini"),
          ),
        ],
      ),
    );
  }
}
