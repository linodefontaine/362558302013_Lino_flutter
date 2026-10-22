import '../../../modul_06/models/sesi_pengguna.dart';
import '../../../modul_06/services/sesi_memori.dart';
import 'sesi_repository.dart';

class MemoriSesiRepository implements SesiRepository {
  final SesiMemori sesiMemori;

  MemoriSesiRepository(this.sesiMemori);

  @override
  String get namaStrategi => 'Memori Proses (Volatil)';

  @override
  Future<SesiPengguna?> baca() async => sesiMemori.baca();

  @override
  Future<void> simpan(SesiPengguna sesi) async => sesiMemori.simpan(sesi);

  @override
  Future<void> hapus() async => sesiMemori.hapus();

  @override
  Future<String?> intipMentah() async {
    final SesiPengguna? sesi = sesiMemori.baca();
    return sesi == null ? null : 'In-Memory Object (RAM): ${sesi.token}';
  }
}