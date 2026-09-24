import 'package:flutter/material.dart';
import '../models/krs_course.dart';
import '../screens/add_krs_screen.dart';
import '../screens/krs_list_screen.dart';
import '../screens/course_detail_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Sistem KRS Mahasiswa'),
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.account_balance,
                size: 72,
                color: Color(0xFF0284C7),
              ),
              const SizedBox(height: 16),
              const Text(
                'Menu Navigasi KRS',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 28),

              // Button 1: Navigasi Biasa ke Form Tambah KRS
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddKrsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add_task),
                label: const Text('1. Tambah KRS (Form Input)'),
              ),
              const SizedBox(height: 12),

              // Button 2: Navigasi ke Daftar KRS
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KrsListScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.list_alt),
                label: const Text('2. Daftar KRS'),
              ),
              const SizedBox(height: 12),

              // Button 3: Navigasi Langsung ke Detail Mata Kuliah (Kirim Data)
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CourseDetailScreen(
                        courseCode: 'TRPL501',
                        course: KrsCourse(
                          code: 'TRPL501',
                          name: 'Pemrograman Perangkat Bergerak',
                          lecturer: 'Sepyan Purnama Kristanto, M.Kom.',
                          sks: 3,
                          description:
                              'Mata kuliah pengembangan aplikasi mobile Flutter.',
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.info_outline),
                label: const Text('3. Detail Mata Kuliah'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
