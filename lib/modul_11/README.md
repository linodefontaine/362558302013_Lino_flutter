# Laporan Praktikum Modul 11: Optimasi Performa

**Nama**: Farrelino Putra Setiawan  
**NIM**: 362558302013  
**Kelas / Prodi**: 2E / Sarjana Terapan TRPL  
**Mata Kuliah**: Pemrograman Perangkat Bergerak  

---

## 1. Ringkasan Implementasi

Pada modul ini, dilakukan pengujian dan optimasi tampilan daftar panjang berisi **1.000 data tugas kuliah** menggunakan Flutter:
- **`ListView.builder`**: Menerapkan pembuatan widget secara malas (*lazy building*), di mana widget kartu hanya dibuat saat masuk ke dalam viewport layar.
- **Pencarian & Pemfilteran**: Menyediakan fitur pencarian teks, filter status (*Semua, Aktif, Selesai*), serta penambahan filter mata kuliah (*Latihan Mandiri*) melalui *getter* `_hasil` tanpa mengubah *state* data mentah (`_semuaTugas`).

---

## 2. Hasil Verifikasi Pengujian (Widget Test & Code Analysis)

### A. Widget Test (`flutter test test/modul_11_test.dart`)
Seluruh 4 skenario pengujian berhasil lulus:
1. `daftar memakai builder dan tidak membuat seribu kartu sekaligus`: Membuktikan bahwa jumlah kartu di *widget tree* awal jauh lebih sedikit dari 1.000 (`lessThan(1000)`).
2. `pencarian membatasi daftar tanpa mengubah sumber data`: Pencarian kata kunci menghasilkan item yang tepat tanpa memotong data asli.
3. `filter status menampilkan hanya tugas selesai`: Filter *Selesai* menghasilkan tepat 250 tugas (kelipatan 4).
4. `filter mata kuliah membatasi daftar sesuai mata kuliah terpilih`: Filter *Dropdown* mata kuliah memperbarui jumlah tampilan tugas secara akurat (500 data).

```text
00:03 +4: All tests passed!