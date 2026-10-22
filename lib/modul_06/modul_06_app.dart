import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'services/auth_api.dart';
import 'services/sesi_memori.dart';

class Modul06App extends StatefulWidget {
  const Modul06App({super.key});

  @override
  State<Modul06App> createState() => _Modul06AppState();
}

class _Modul06AppState extends State<Modul06App> {
  late final AuthApi _api;
  late final SesiMemori _sesiMemori;

  @override
  void initState() {
    super.initState();
    _api =const AuthApi();
    _sesiMemori = SesiMemori();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 06',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: LoginScreen(
        api: _api,
        sesiMemori: _sesiMemori,
      ),
    );
  }
}