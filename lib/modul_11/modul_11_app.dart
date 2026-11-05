import 'package:flutter/material.dart';

// Model data tugas
class Tugas {
  final int id;
  final String judul;
  final String mataKuliah;
  final bool isSelesai;

  const Tugas({
    required this.id,
    required this.judul,
    required this.mataKuliah,
    required this.isSelesai,
  });
}

class Modul11App extends StatelessWidget {
  const Modul11App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Kuliah TRPL - Modul 11',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7)),
        useMaterial3: true,
      ),
      home: const HalamanTugasKuliah(),
    );
  }
}

class HalamanTugasKuliah extends StatefulWidget {
  const HalamanTugasKuliah({super.key});

  @override
  State<HalamanTugasKuliah> createState() => _HalamanTugasKuliahState();
}

class _HalamanTugasKuliahState extends State<HalamanTugasKuliah> {
  // 1. Data sumber 1.000 tugas
  late final List<Tugas> _semuaTugas;

  // State untuk filter dan pencarian
  String _kueri = '';
  String _filterStatus = 'Semua'; // 'Semua', 'Aktif', 'Selesai'

  @override
  void initState() {
    super.initState();
    // Generate 1.000 data: id kelipatan 4 selesai (total 250 data)
    _semuaTugas = List.generate(1000, (index) {
      final id = index + 1;
      final paddedId = id.toString().padLeft(4, '0');
      return Tugas(
        id: id,
        judul: 'Tugas praktikum $paddedId',
        mataKuliah: 'Pemrograman Perangkat Bergerak',
        isSelesai: id % 4 == 0,
      );
    });
  }

  // Getter data yang disaring sesuai pencarian & status
  List<Tugas> get _hasil {
    return _semuaTugas.where((tugas) {
      final cocokKueri = tugas.judul.toLowerCase().contains(_kueri.toLowerCase());

      final cocokStatus = switch (_filterStatus) {
        'Selesai' => tugas.isSelesai,
        'Aktif' => !tugas.isSelesai,
        _ => true,
      };

      return cocokKueri && cocokStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final hasilList = _hasil;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas Kuliah TRPL'),
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Bagian Input Pencarian
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              key: const ValueKey('task-search'),
              decoration: const InputDecoration(
                labelText: 'Cari tugas...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                setState(() {
                  _kueri = val;
                });
              },
            ),
          ),

          // Pilihan FilterChip Status
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('Semua'),
                  selected: _filterStatus == 'Semua',
                  onSelected: (selected) {
                    setState(() {
                      _filterStatus = 'Semua';
                    });
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Aktif'),
                  selected: _filterStatus == 'Aktif',
                  onSelected: (selected) {
                    setState(() {
                      _filterStatus = 'Aktif';
                    });
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Selesai'),
                  selected: _filterStatus == 'Selesai',
                  onSelected: (selected) {
                    setState(() {
                      _filterStatus = 'Selesai';
                    });
                  },
                ),
              ],
            ),
          ),

          // Teks Status Counter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Text(
              'Menampilkan ${hasilList.length} dari ${_semuaTugas.length} tugas',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),

          // Daftar Menggunakan ListView.builder
          Expanded(
            child: ListView.builder(
              itemCount: hasilList.length,
              itemBuilder: (context, index) {
                final tugas = hasilList[index];
                return Card(
                  key: ValueKey('task-card-${tugas.id}'),
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: ListTile(
                    title: Text(tugas.judul),
                    subtitle: Text(tugas.mataKuliah),
                    trailing: Chip(
                      label: Text(
                        tugas.isSelesai ? 'Selesai' : 'Aktif',
                        style: TextStyle(
                          fontSize: 11,
                          color: tugas.isSelesai ? Colors.green[800] : Colors.orange[800],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}