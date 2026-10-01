import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/krs_course.dart';

// Menggunakan Notifier (standar Riverpod modern pengganti StateNotifier)
class KrsNotifier extends Notifier<List<KrsCourse>> {
  @override
  List<KrsCourse> build() {
    return KrsCourse.getInitialCourses();
  }

  // Menambah mata kuliah ke dalam KRS
  bool tambahMataKuliah(KrsCourse course) {
    // 1. Cek duplikasi kode mata kuliah
    final exists =
        state.any((c) => c.code.toUpperCase() == course.code.toUpperCase());
    if (exists) return false;

    // 2. Cek batas maksimal 24 SKS
    final totalSks = state.fold<int>(0, (sum, item) => sum + item.sks);
    if (totalSks + course.sks > 24) return false;

    // 3. Emit state baru secara immutable
    state = [...state, course];
    return true;
  }

  // Menghapus mata kuliah dari KRS
  void hapusMataKuliah(String code) {
    state = state.where((c) => c.code != code).toList();
  }

  // Menghitung total SKS saat ini
  int get totalSks => state.fold<int>(0, (sum, item) => sum + item.sks);
}

// Provider untuk KrsNotifier
final krsProvider = NotifierProvider<KrsNotifier, List<KrsCourse>>(
  KrsNotifier.new,
);

// Provider untuk menghitung total SKS yang dibutuhkan krs_list_screen.dart
final totalSksProvider = Provider<int>((ref) {
  final list = ref.watch(krsProvider);
  return list.fold<int>(0, (sum, item) => sum + item.sks);
});
