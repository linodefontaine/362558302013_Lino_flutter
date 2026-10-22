abstract class PenyimpananAman {
  Future<String?> baca(String kunci);
  Future<void> tulis(String kunci, String nilai);
  Future<void> hapus(String kunci);
  Future<bool> berisi(String kunci);
  Future<String?> bacaMentah(String kunci);
}