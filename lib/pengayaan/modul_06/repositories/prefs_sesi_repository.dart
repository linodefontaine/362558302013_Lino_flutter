import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../modul_06/models/sesi_pengguna.dart';
import 'sesi_repository.dart';

class PrefsSesiRepository implements SesiRepository {
  static const String kunciSesi = 'sesi_plaintext';
  final Future<SharedPreferences> _prefs;

  PrefsSesiRepository([Future<SharedPreferences>? prefs])
      : _prefs = prefs ?? SharedPreferences.getInstance();

  @override
  String get namaStrategi => 'SharedPreferences (Plaintext)';

  @override
  Future<SesiPengguna?> baca() async {
    final SharedPreferences prefs = await _prefs;
    final String? data = prefs.getString(kunciSesi);
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
    final SharedPreferences prefs = await _prefs;
    final Map<String, dynamic> peta = <String, dynamic>{
      'nama': sesi.nama,
      'email': sesi.email,
      'peran': sesi.peran,
      'token': sesi.token,
      'masukPada': sesi.masukPada,
      'kedaluwarsaPada': sesi.kedaluwarsaPada,
    };
    await prefs.setString(kunciSesi, jsonEncode(peta));
  }

  @override
  Future<void> hapus() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(kunciSesi);
  }

  @override
  Future<String?> intipMentah() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(kunciSesi);
  }
}