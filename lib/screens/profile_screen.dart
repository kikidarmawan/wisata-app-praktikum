import 'package:flutter/material.dart';
import 'package:wisata_app/helper/session_manager.dart';
import 'package:wisata_app/screens/login_screen.dart';
import 'package:wisata_app/services/auth_services.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _logout() async {
    final result = await AuthService().logout();

    if (result['success']) {
      print('berhasil');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    } else {
      // toast
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              // Ganti dengan logika untuk menampilkan gambar profil.
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Nama Pengguna',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Email Pengguna',
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                // Logika untuk tombol Edit Profil
              },
              child: Text('Edit Profil'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Logika untuk tombol Keluar
                _logout();
              },
              child: Text('Keluar'),
            ),
          ],
        ),
      ),
    );
  }
}
