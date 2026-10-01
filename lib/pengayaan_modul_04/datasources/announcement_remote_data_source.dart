import 'package:dio/dio.dart';
import '../../modul_04/models/announcement.dart';

class AnnouncementRemoteDataSource {
  AnnouncementRemoteDataSource({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://jsonplaceholder.typicode.com',
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  final Dio _dio;

  static const List<String> daftarKategori = <String>[
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  Future<List<Announcement>> fetchAnnouncements() async {
    final response = await _dio.get('/posts', queryParameters: {'_limit': 10});

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data as List<dynamic>;
      return List<Announcement>.generate(
        data.length,
        (i) {
          final item = data[i] as Map<String, dynamic>;
          return Announcement.fromJson({
            'id': item['id'],
            'title': item['title'],
            'content': item['body'],
            'author': 'Bagian Akademik Poliwangi',
            'category': daftarKategori[i % daftarKategori.length],
            'date': '2026-09-${(i % 28 + 1).toString().padLeft(2, '0')}',
            'readCount': (i + 1) * 37,
          });
        },
      );
    }
    throw Exception('Gagal memuat data dari server');
  }
}