import 'package:flutter/material.dart';
import '../../../modul_06/services/auth_api.dart';
import '../../../modul_06/services/sesi_memori.dart';
import 'controllers/sesi_controller.dart';
import 'repositories/memori_sesi_repository.dart';
import 'widgets/gerbang_sesi.dart';

class Modul06PengayaanApp extends StatefulWidget {
  const Modul06PengayaanApp({super.key});

  @override
  State<Modul06PengayaanApp> createState() => _Modul06PengayaanAppState();
}

class _Modul06PengayaanAppState extends State<Modul06PengayaanApp> {
  late final AuthApi _api;
  late final SesiMemori _sesiMemori;
  late final SesiController _controller;

  @override
  void initState() {
    super.initState();
    _api = const AuthApi();
    _sesiMemori = SesiMemori();
    _controller = SesiController(
      api: _api,
      repository: MemoriSesiRepository(_sesiMemori),
    );
    _controller.pulihkanSesi();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 06 — Pengayaan Sesi',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: GerbangSesi(controller: _controller),
    );
  }
}