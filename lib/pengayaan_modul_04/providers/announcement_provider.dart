import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modul_04/models/announcement.dart';
import '../repositories/announcement_repository.dart';
import '../repositories/announcement_repository_impl.dart';

// 1. Provider instance Repository
final announcementRepositoryProvider = Provider<AnnouncementRepository>((ref) {
  return AnnouncementRepositoryImpl();
});

// 2. Notifier untuk filter kategori (pengganti StateProvider di Riverpod modern)
class SelectedCategoryNotifier extends Notifier<String> {
  @override
  String build() => 'Semua';

  void setCategory(String category) => state = category;
}

final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, String>(
  SelectedCategoryNotifier.new,
);

// 3. FutureProvider untuk memuat daftar pengumuman
final announcementsProvider = FutureProvider<List<Announcement>>((ref) async {
  final repository = ref.watch(announcementRepositoryProvider);
  final category = ref.watch(selectedCategoryProvider);

  return repository.getAnnouncements(category: category);
});