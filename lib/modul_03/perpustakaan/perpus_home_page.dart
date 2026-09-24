import 'package:flutter/material.dart';

class PerpusHomePage extends StatelessWidget {
  const PerpusHomePage({super.key});

  final List<Map<String, dynamic>> books = const [
    {
      'title': 'Pemrograman Flutter',
      'author': 'Andi Saputra',
      'available': 3,
      'year': '2024',
      'category': 'Teknologi',
      'desc': 'Buku ini membahas dasar hingga praktik membangun aplikasi Flutter.',
      'color': Color(0xFF0284C7),
      'tag': 'Flutter',
    },
    {
      'title': 'Dasar Dart',
      'author': 'Budi Santoso',
      'available': 5,
      'year': '2023',
      'category': 'Pemrograman',
      'desc': 'Panduan komprehensif memahami sintaks dan fitur bahasa Dart.',
      'color': Color(0xFF0F172A),
      'tag': 'DART',
    },
    {
      'title': 'Desain UI/UX',
      'author': 'Citra Lestari',
      'available': 2,
      'year': '2024',
      'category': 'Desain',
      'desc': 'Prinsip desain pengalaman pengguna untuk aplikasi mobile modern.',
      'color': Color(0xFFEA580C),
      'tag': 'UI/UX',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.menu_book, color: Colors.white),
            SizedBox(width: 8),
            Text('Perpustakaan Kampus',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: books.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final book = books[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    width: 65,
                    height: 85,
                    decoration: BoxDecoration(
                      color: book['color'] as Color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        book['tag'] as String,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                book['title'] as String,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                          ],
                        ),
                        Text(
                          book['author'] as String,
                          style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Tersedia: ${book['available']} Buku',
                          style: const TextStyle(
                            color: Color(0xFF16A34A),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height: 32,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1976D2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                              ),
                              onPressed: () {
                                // Sesuai modul: Navigator.push()
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => _PerpusDetailPage(book: book),
                                  ),
                                );
                              },
                              child: const Text('Lihat Detail',
                                  style: TextStyle(fontSize: 12, color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PerpusDetailPage extends StatelessWidget {
  const _PerpusDetailPage({required this.book});

  final Map<String, dynamic> book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book['title'] as String)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book['author'] as String,
                style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 12),
            Text(book['desc'] as String),
            const SizedBox(height: 12),
            Text('Kategori: ${book['category']}'),
            Text('Tahun terbit: ${book['year']}'),
            Text('Tersedia: ${book['available']} buku'),
          ],
        ),
      ),
    );
  }
}