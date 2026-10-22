# Pengayaan Modul 06: Multi-Storage Session Management

Proyek ini merupakan implementasi pengayaan Modul 06 pada praktikum pemrograman mobile Flutter. Fokus utamanya adalah menerapkan **Repository Pattern** untuk mengelola sesi pengguna menggunakan beberapa strategi penyimpanan (*storage strategy*) yang bisa ditukar secara runtime tanpa merombak layer antarmuka pengguna (UI).

---

## 1. Konsep & Arsitektur

Arsitektur kode disusun menggunakan pemisahan tanggung jawab (*separation of concerns*) agar logika aplikasi independen dari media penyimpanan fisik:

[UI Screen / Widgets]
│
[SesiController] ── (Mengatur state sesi & pergantian repository)
│
[SesiRepository] ── (Interface / Kontrak data)
├── MemoriSesiRepository     --> SesiMemori (RAM/Volatile)
├── PrefsSesiRepository      --> SharedPreferences (Plaintext JSON)
└── AmanSesiRepository       --> FlutterSecureStorage (Enkripsi Hardware)

### Mengapa Menggunakan Repository Pattern?
Dengan adanya kontrak antarmuka `SesiRepository`, class controller maupun widget tidak perlu tahu apakah data disimpan di RAM, SharedPreferences, atau Secure Storage. Jika suatu saat ingin menambah mekanisme penyimpanan baru (seperti Hive atau SQLite), cukup buat class baru yang mengimplementasikan `SesiRepository` tanpa mengubah satu pun baris kode di layar login atau beranda.

---

## 2. Penjelasan Cara Kerja Komponen

1. **`SesiRepository` (Interface)**
   Kontrak dasar yang mewajibkan seluruh implementasi memiliki fungsi seragam:
   * `baca()`: Mengambil sesi aktif dari storage.
   * `simpan(sesi)`: Menulis data sesi pengguna.
   * `hapus()`: Menghapus data sesi saat logout.
   * `intipMentah()`: Membaca teks asli yang tersimpan di disk untuk kebutuhan diagnostik.

2. **Strategi Penyimpanan:**
   * **Memori (`MemoriSesiRepository`)**: Menyimpan sesi pada variabel memori internal (`SesiMemori`). Cocok untuk pengujian cepat, namun sesi akan langsung hilang begitu aplikasi ditutup atau direstart (*hot restart*).
   * **Plaintext (`PrefsSesiRepository`)**: Menggunakan `shared_preferences`. Data sesi diserialisasi menjadi teks JSON biasa. Data bertahan saat aplikasi ditutup, namun rawan dibaca jika perangkat dalam kondisi *rooted/jailbroken*.
   * **Terenkripsi (`AmanSesiRepository`)**: Memanfaatkan pustaka `flutter_secure_storage`. Mengamankan token dan payload sesi menggunakan subsistem keamanan bawaan OS (Android Keystore atau iOS Keychain).

3. **`SesiController` (State Management)**
   Berperan sebagai penghubung antara UI dan repository. Controller ini menyimpan state aktif (`memuat`, `masuk`, `keluar`, `gagal`) dan menyediakan method `gantiStrategiPenyimpanan()` agar media penyimpanan bisa dialihkan kapan saja.

4. **`GerbangSesi` & `PapanDiagnostikPenyimpanan` (UI)**
   * `GerbangSesi` memantau state controller untuk menentukan apakah aplikasi harus menampilkan layar loading, form login, atau halaman beranda.
   * `PapanDiagnostikPenyimpanan` menyediakan kontrol visual berupa `ChoiceChip` untuk menguji pertukaran storage, serta tombol periksa untuk mengintip isi fisik penyimpanan SharedPreferences dan Secure Storage secara transparan.

---

## 3. Struktur Direktori

```text
lib/
├── modul_06/
│   ├── models/
│   │   └── sesi_pengguna.dart
│   ├── services/
│   │   ├── auth_api.dart
│   │   └── sesi_memori.dart
│   └── widgets/
│       ├── field_kata_sandi.dart
│       └── kartu_sesi.dart
└── pengayaan/
    └── modul_06/
        ├── controllers/
        │   └── sesi_controller.dart
        ├── repositories/
        │   ├── aman_sesi_repository.dart
        │   ├── memori_sesi_repository.dart
        │   ├── prefs_sesi_repository.dart
        │   └── sesi_repository.dart
        ├── screens/
        │   ├── beranda_pengayaan_screen.dart
        │   └── login_pengayaan_screen.dart
        ├── storage/
        │   ├── penyimpanan_aman.dart
        │   └── penyimpanan_aman_platform.dart
        ├── widgets/
        │   ├── gerbang_sesi.dart
        │   └── papan_diagnostik_penyimpanan.dart
        └── modul_06_pengayaan_app.dart

        Alur Pengujian & Hasil AnalisisNoLangkah PengujianPerilaku yang Diamati
        1Pilih Memori -> Login -> Restart aplikasiSesi langsung tereset ke posisi awal (logout) karena RAM dibersihkan.
        2Pilih Prefs (Plaintext) -> Login -> Tekan "Periksa"Data sesi terbaca dalam wujud JSON string biasa pada baris SharedPreferences.
        3Pilih Secure Storage -> Login -> Tekan "Periksa"Data tersimpan aman di Secure Storage tanpa mengekspos token plaintext sembarangan.
        4Switch strategi saat sedang loginSesi lama tetap berada di media sebelumnya hingga dihapus atau ditimpa oleh sesi baru.