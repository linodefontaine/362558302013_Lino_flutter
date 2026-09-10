// Model data untuk mata kuliah

class Course {
  final String code;
  final String name;
  final String lecturer;
  final int sks;
  final double progress; // progres silabus (0.0 - 1.0)
  final String room;
  final String category; // Tambahan properti kategori untuk ChoiceChip

  const Course({
    required this.code,
    required this.name,
    required this.lecturer,
    required this.sks,
    required this.progress,
    this.room = 'Lab Komputer 3',
    required this.category, // Wajib diisi pada setiap objek course
  });

  // Data dummy untuk bahan praktikum & testing
  static List<Course> getSampleCourses() {
    return const [
      Course(
        code: 'TRPL501',
        name: 'Pemrograman Perangkat Bergerak',
        lecturer: 'Sepyan Purnama Kristanto',
        sks: 4,
        progress: 0.25,
        room: 'Lab Komputer 3',
        category: 'Praktikum', // Ditentukan sebagai Praktikum
      ),
      Course(
        code: 'TRPL502',
        name: 'Basis data lanjut',
        lecturer: 'Eka Mistiko',
        sks: 3,
        progress: 0.40,
        room: 'Ruang Teori 201',
        category: 'Teori', // Ditentukan sebagai Teori
      ),
      Course(
        code: 'TRPL503',
        name: 'Manajemen Proyek Agile & DevOps',
        lecturer: 'soo Hwan Kim',
        sks: 3,
        progress: 0.60,
        room: 'Ruang Teori 104',
        category: 'Teori', // Ditentukan sebagai Teori
      ),
      Course(
        code: 'TRPL504',
        name: 'Penjaminan Mutu Perangkat Lunak (QA)',
        lecturer: 'soo hee Kim',
        sks: 2,
        progress: 0.15,
        room: 'Lab Jaringan',
        category: 'Praktikum', // Ditentukan sebagai Praktikum
      ),
    ];
  }
}