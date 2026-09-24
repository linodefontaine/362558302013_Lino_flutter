import 'package:flutter/material.dart';
import '../latihan_dasar/perpustakaan/perpus_home_page.dart';

class Modul03App extends StatelessWidget {
  const Modul03App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perpustakaan Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
        useMaterial3: true,
      ),
      home: const PerpusHomePage(),
    );
  }
}