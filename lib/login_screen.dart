import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_task_app/home_screen.dart';
import 'package:todo_task_app/services/auth_services.dart';
import 'package:todo_task_app/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1d2630),
        foregroundColor: Colors.white,
        title: const Text("Sign In"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                "Welcome Back",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
              const Text(
                "Log In Here",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white60),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Email",
                  labelStyle: const TextStyle(color: Colors.white60),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white60),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Password",
                  labelStyle: const TextStyle(color: Colors.white60),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.5,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      // Mencetak email dan password untuk debugging
                      print('Email: ${_emailController.text}');
                      print('Password: ${_passwordController.text}');

                      User? user = await _auth.signInWithEmailAndPassword(
                        _emailController.text,
                        _passwordController.text,
                      );

                      // Jika login berhasil, arahkan ke HomeScreen
                      if (user != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      // Tampilkan pesan error jika login gagal
                      String errorMessage;

                      // Memastikan untuk menangani setiap kasus dengan tepat
                      switch (e.code) {
                        case 'user-not-found':
                          errorMessage = 'Email tidak terdaftar.';
                          break;
                        case 'wrong-password':
                          errorMessage = 'Password salah.';
                          break;
                        case 'invalid-email':
                          errorMessage = 'Format email tidak valid.';
                          break;
                        case 'user-disabled':
                          errorMessage = 'Akun ini telah dinonaktifkan.';
                          break;
                        default:
                          errorMessage =
                              'Terjadi kesalahan. Silakan coba lagi.';
                          break;
                      }

                      // Tampilkan pesan kesalahan menggunakan SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } catch (e) {
                      // Menangani kesalahan lain yang mungkin terjadi
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Terjadi kesalahan: ${e.toString()}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.indigo, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("OR", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
