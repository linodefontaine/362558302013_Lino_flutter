import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/announcement_list_screen.dart';

class PengayaanModul04App extends StatelessWidget {
  const PengayaanModul04App({super.key});

  @override
  Widget build(BuildContext context) {
    // Fase B wajib dibungkus ProviderScope agar Riverpod berfungsi
    return const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pengayaan Modul 04 — Dio & Riverpod',
        home: AnnouncementListScreen(),
      ),
    );
  }
}
