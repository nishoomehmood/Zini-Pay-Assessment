import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _apiKeyController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('https://sfs-app-test-server.vercel.app/app/auth'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': _emailController.text,
        'apiKey': _apiKeyController.text,
      }),
    );

    final Map<String, dynamic> responseData = jsonDecode(response.body);

    setState(() {
      _isLoading = false;
    });

    if (responseData['success']) {
      // Navigate to HomePage on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Show error message if login failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${responseData['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 45.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/illustration.png', height: 250),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Log in',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                labelText: 'Email',
                hintText: 'Johndoe@example.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _apiKeyController,
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                labelText: 'API Key',
                hintText: 'Enter your API Key',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007BFF),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Log in', style: TextStyle(color: Colors.white70)),
            ),
          ],
        ),
      ),
    );
  }
}
