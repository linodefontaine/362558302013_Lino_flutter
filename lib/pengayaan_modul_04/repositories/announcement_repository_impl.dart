import '../../modul_04/models/announcement.dart';
import 'package:dio/dio.dart';
import '../datasources/announcement_remote_data_source.dart';
import 'announcement_repository.dart';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  AnnouncementRepositoryImpl({AnnouncementRemoteDataSource? dataSource})
      : _dataSource = dataSource ?? AnnouncementRemoteDataSource();

  final AnnouncementRemoteDataSource _dataSource;

  @override
  Future<List<Announcement>> getAnnouncements({String? category}) async {
    try {
      final list = await _dataSource.fetchAnnouncements();
      if (category == null || category == 'Semua') {
        return list;
      }
      return list.where((item) => item.category == category).toList();
    } on DioException catch (e) {
      // Menerjemahkan DioException menjadi pesan user-friendly
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Koneksi timeout. Periksa internet Anda.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Gagal terhubung ke server.');
      }
      throw Exception('Terjadi kesalahan jaringan: ${e.message}');
    }
  }

  @override
  Future<Announcement> addAnnouncement(Announcement announcement) async {
    // Sesuai kebutuhan fungsi addAnnouncement pada kontrak
    return announcement;
  }
}