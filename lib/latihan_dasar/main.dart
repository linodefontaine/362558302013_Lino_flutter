import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latihan Navigasi Dasar',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const LatihanHomePage(),
    );
  }
}

// ----------------- LAYAR 1: BERANDA -----------------
class LatihanHomePage extends StatelessWidget {
  const LatihanHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman 1 (Beranda)'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, size: 80, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              'Ini Halaman Beranda',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Berpindah ke Halaman Detail (Layar 2)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailPage(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Buka Halaman Detail'),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------- LAYAR 2: DETAIL -----------------
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman 2 (Detail)'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.info_outline, size: 80, color: Colors.indigo),
            const SizedBox(height: 16),
            const Text(
              'Ini Halaman Detail',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Kembali ke Halaman 1
                Navigator.pop(context);
              },
              child: const Text('Kembali (Pop)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Mengganti tumpukan layar dengan Halaman 3 (Halaman 2 dibuang)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SuccessPage(),
                  ),
                );
              },
              child: const Text('Lanjut ke Sukses (PushReplacement)'),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------- LAYAR 3: SUKSES -----------------
class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman 3 (Sukses)'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
            const SizedBox(height: 16),
            const Text(
              'Ini Halaman Sukses',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Karena Halaman 2 sudah diganti (pushReplacement),
                // pop() di sini otomatis langsung kembali ke Halaman 1 (Beranda)!
                Navigator.pop(context);
              },
              icon: const Icon(Icons.home),
              label: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }
}