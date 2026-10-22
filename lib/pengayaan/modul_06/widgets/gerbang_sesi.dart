import 'package:flutter/material.dart';
import '../controllers/sesi_controller.dart';
import '../screens/beranda_pengayaan_screen.dart';
import '../screens/login_pengayaan_screen.dart';

class GerbangSesi extends StatelessWidget {
  final SesiController controller;

  const GerbangSesi({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        switch (controller.status) {
          case StatusSesiState.memuat:
            return const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Memeriksa status sesi…'),
                  ],
                ),
              ),
            );
          case StatusSesiState.masuk:
            return BerandaPengayaanScreen(controller: controller);
          case StatusSesiState.keluar:
          case StatusSesiState.gagal:
            return LoginPengayaanScreen(controller: controller);
        }
      },
    );
  }
}