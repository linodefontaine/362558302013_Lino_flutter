# Laporan Praktikum Modul 02: Declarative UI & Responsive Layout

- **Nama**: [FARRELINO PUTRA SETIAWAN]
- **NIM**: [362558302013]
- **Kelas / Prodi**: 2E / Sarjana Terapan TRPL
- **Mata Kuliah**: Pemrograman Perangkat Bergerak (Semester 3)

---

## 1. Ringkasan Implementasi
| Pada pengembangan dashboard ini, pendekatan responsive design diterapkan menggunakan widget LayoutBuilder agar aplikasi mampu beradaptasi secara dinamis terhadap berbagai ukuran layar. Secara garis besar, struktur tata letaknya dibagi menjadi dua kondisi: untuk perangkat seluler dengan lebar di bawah 600dp, elemen disusun secara vertikal menggunakan ListView, sementara pada layar tablet atau perangkat yang lebih luas (minimal 600dp), tata letak otomatis berubah menjadi GridView dua kolom agar ruang yang ada termanfaatkan secara optimal.

Tidak hanya itu, keseluruhan antarmuka juga diperkaya dengan standar Material 3 melalui ColorScheme.fromSeed, sehingga transisi antara mode terang dan gelap dapat berjalan mulus secara instan sesuai kenyamanan pengguna. |

## 2. Bukti Tangkapan Layar (Running App)
| Mode Portrait (Light) | Mode Dark Theme | Mode Landscape / Tablet (2 Kolom) |
|---|---|---|
| |

## 3. Kendala Layout yang Dihadapi & Solusinya
- **Kendala**: Terjadi overflow horizontal pada teks informasi mata kuliah dan total SKS karena ruang baris yang sempit di dalam layar pengujian.
- **Solusi**: Membungkus widget Text judul mata kuliah dengan Expanded serta menambahkan properti overflow: TextOverflow.ellipsis agar teks yang terlalu panjang terpotong rapi tanpa merusak batas kontainer.

## 4. Jawaban Pertanyaan Refleksi
1. **Efisiensi Single-pass BoxConstraints**: | LayoutBuilder bekerja dengan cara mengevaluasi batasan (constraints) yang diberikan oleh parent widget secara langsung dalam satu kali proses render, sehingga tata letak dapat menyesuaikan dimensi secara efisien tanpa memicu komputasi ulang yang berlebihan.
2. **Kriteria Modularisasi Widget**: Komponen UI dipisah menjadi widget mandiri (seperti CourseCard dan HeaderBanner) apabila kode komponen tersebut memiliki kompleksitas tinggi, digunakan secara berulang di berbagai bagian, atau untuk menjaga kerapian file utama (separation of concerns).
3. **Manfaat M3 ThemeData Terpusat**: Penerapan ThemeData terpusat berbasis Material 3 memudahkan pengelolaan konsistensi warna, tipografi, dan kontras otomatis (ColorScheme.fromSeed) di seluruh layar aplikasi tanpa harus mengatur gaya komponen satu per satu secara manual.