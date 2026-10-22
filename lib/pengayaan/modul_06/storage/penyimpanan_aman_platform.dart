import 'package:flutter_secure_storage/flutter_secure_storage.dart' as secure_storage;
import 'penyimpanan_aman.dart';

class PenyimpananAmanPlatform implements PenyimpananAman {
    final secure_storage.FlutterSecureStorage _storage;

    const PenyimpananAmanPlatform([secure_storage.FlutterSecureStorage? storage])
      : _storage = storage ?? const secure_storage.FlutterSecureStorage();

  @override
  Future<String?> baca(String kunci) async {
    return _storage.read(key: kunci);
  }

  @override
  Future<void> tulis(String kunci, String nilai) async {
    await _storage.write(key: kunci, value: nilai);
  }

  @override
  Future<void> hapus(String kunci) async {
    await _storage.delete(key: kunci);
  }

  @override
  Future<bool> berisi(String kunci) async {
    return _storage.containsKey(key: kunci);
  }

  @override
  Future<String?> bacaMentah(String kunci) async {
    return _storage.read(key: kunci);
  }
}