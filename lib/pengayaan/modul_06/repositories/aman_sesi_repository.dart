import 'dart:convert';
import '../../../modul_06/models/sesi_pengguna.dart';
import '../storage/penyimpanan_aman.dart';
import 'sesi_repository.dart';

class AmanSesiRepository implements SesiRepository {
  static const String kunciSesi = 'sesi_enkripsi_aman';
  final PenyimpananAman _penyimpanan;

  const AmanSesiRepository(this._penyimpanan);

  @override
  String get namaStrategi => 'Secure Storage (Terenkripsi)';

  @override
  Future<SesiPengguna?> baca() async {
    final String? data = await _penyimpanan.baca(kunciSesi);
    if (data == null || data.isEmpty) return null;

    try {
      final Map<String, dynamic> peta =
          jsonDecode(data) as Map<String, dynamic>;
      return SesiPengguna(
        nama: peta['nama'] as String,
        email: peta['email'] as String,
        peran: peta['peran'] as String,
        token: peta['token'] as String,
        masukPada: peta['masukPada'] as String,
        kedaluwarsaPada: peta['kedaluwarsaPada'] as String,
      );
    } catch (_) {
      await hapus();
      return null;
    }
  }

  @override
  Future<void> simpan(SesiPengguna sesi) async {
    final Map<String, dynamic> peta = <String, dynamic>{
      'nama': sesi.nama,
      'email': sesi.email,
      'peran': sesi.peran,
      'token': sesi.token,
      'masukPada': sesi.masukPada,
      'kedaluwarsaPada': sesi.kedaluwarsaPada,
    };
    await _penyimpanan.tulis(kunciSesi, jsonEncode(peta));
  }

  @override
  Future<void> hapus() async {
    await _penyimpanan.hapus(kunciSesi);
  }

  @override
  Future<String?> intipMentah() async {
    return _penyimpanan.baca(kunciSesi);
  }
}