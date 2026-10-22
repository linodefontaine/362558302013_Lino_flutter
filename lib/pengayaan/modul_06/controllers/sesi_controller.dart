import 'package:flutter/foundation.dart';
import '../../../modul_06/models/sesi_pengguna.dart';
import '../../../modul_06/services/auth_api.dart';
import '../repositories/sesi_repository.dart';

enum StatusSesiState { memuat, masuk, keluar, gagal }

class SesiController extends ChangeNotifier {
  final AuthApi _api;
  SesiRepository _repository;
  final DateTime Function() _jam;

  StatusSesiState _status = StatusSesiState.memuat;
  SesiPengguna? _sesi;
  String? _pesanKesalahan;
  bool _sedangMemproses = false;

  SesiController({
    required AuthApi api,
    required SesiRepository repository,
    DateTime Function() jam = DateTime.now,
  })  : _api = api,
        _repository = repository,
        _jam = jam;

  StatusSesiState get status => _status;
  SesiPengguna? get sesi => _sesi;
  String? get pesanKesalahan => _pesanKesalahan;
  bool get sedangMemproses => _sedangMemproses;
  SesiRepository get repository => _repository;

  Future<void> pulihkanSesi() async {
    _status = StatusSesiState.memuat;
    notifyListeners();

    try {
      final SesiPengguna? tersimpan = await _repository.baca();
      if (tersimpan == null) {
        _status = StatusSesiState.keluar;
      } else if (tersimpan.sudahKedaluwarsa(_jam())) {
        await _repository.hapus();
        _pesanKesalahan = 'Sesi telah kedaluwarsa. Silakan masuk kembali.';
        _status = StatusSesiState.gagal;
      } else {
        _sesi = tersimpan;
        _status = StatusSesiState.masuk;
      }
    } catch (_) {
      _pesanKesalahan = 'Gagal memulihkan sesi dari media penyimpanan.';
      _status = StatusSesiState.gagal;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> masuk(String email, String sandi) async {
    if (_sedangMemproses) return false;
    _sedangMemproses = true;
    _pesanKesalahan = null;
    notifyListeners();

    try {
      final SesiPengguna hasil = await _api.masuk(email: email, sandi: sandi);
      await _repository.simpan(hasil);
      _sesi = hasil;
      _status = StatusSesiState.masuk;
      return true;
    } on AuthException catch (e) {
      _pesanKesalahan = e.pesan;
      _status = StatusSesiState.gagal;
      return false;
    } catch (_) {
      _pesanKesalahan = 'Terjadi kesalahan sistem saat mencoba masuk.';
      _status = StatusSesiState.gagal;
      return false;
    } finally {
      _sedangMemproses = false;
      notifyListeners();
    }
  }

  Future<void> keluar() async {
    if (_sedangMemproses) return;
    _sedangMemproses = true;
    notifyListeners();

    try {
      await _repository.hapus();
      _sesi = null;
      _status = StatusSesiState.keluar;
      _pesanKesalahan = null;
    } finally {
      _sedangMemproses = false;
      notifyListeners();
    }
  }

  Future<void> gantiStrategiPenyimpanan(SesiRepository repositoryBaru) async {
    _repository = repositoryBaru;
    await pulihkanSesi();
  }
}