import 'package:flutter/material.dart';

class Modul03App extends StatelessWidget {
  const Modul03App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latihan Dasar Navigasi',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Latihan Dasar Navigasi'),
        ),
      ), // Menampilkan langsung layar latihan awal
    );
  }
}