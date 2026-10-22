import 'package:flutter/material.dart';
import '../../../modul_06/models/sesi_pengguna.dart';
import '../../../modul_06/widgets/kartu_sesi.dart';
import '../controllers/sesi_controller.dart';
import '../widgets/papan_diagnostik_penyimpanan.dart';

class BerandaPengayaanScreen extends StatelessWidget {
  final SesiController controller;

  const BerandaPengayaanScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final SesiPengguna? sesi = controller.sesi;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda Pengayaan'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            if (sesi != null)
              KartuSesi(
                sesi: sesi,
                sekarang: DateTime.now(),
                onKeluar: controller.keluar,
                sedangKeluar: controller.sedangMemproses,
              ),
            const SizedBox(height: 20),
       PapanDiagnostikPenyimpanan(controller: controller),
          ],
        ),
      ),
    );
  }
}