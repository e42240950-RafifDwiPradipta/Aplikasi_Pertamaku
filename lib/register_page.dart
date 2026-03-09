import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  static String? registeredUser;
  static String? registeredPass;

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // 1. Tambah GlobalKey untuk memvalidasi Form 
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _handleRegister() {
    // 2. Cek validasi form sebelum memproses data 
    if (_formKey.currentState!.validate()) {
      RegisterPage.registeredUser = _userController.text;
      RegisterPage.registeredPass = _passController.text;

      // 3. Tambah SnackBar untuk notifikasi berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registrasi Berhasil! Account Created Successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text("Create Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        // 4. Bungkus Column dengan widget Form 
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Join the Culture",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              // 5. Ganti TextField menjadi TextFormField
              TextFormField(
                controller: _userController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "New Username",
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                // 6.logika validator
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username tidak boleh kosong"; // Menghindari data kosong
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "New Password",
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                // 7. Validator Password dengan aturan panjang karakter 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password wajib diisi";
                  }
                  if (value.length < 6) {
                    return "Password minimal 6 karakter"; // Memastikan format data
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text("REGISTER NOW"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
