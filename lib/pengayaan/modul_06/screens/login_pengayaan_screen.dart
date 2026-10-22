import 'package:flutter/material.dart';
import '../../../modul_06/services/auth_api.dart';
import '../../../modul_06/widgets/field_kata_sandi.dart';
import '../controllers/sesi_controller.dart';
import '../widgets/papan_diagnostik_penyimpanan.dart';

class LoginPengayaanScreen extends StatefulWidget {
  final SesiController controller;

  const LoginPengayaanScreen({super.key, required this.controller});

  @override
  State<LoginPengayaanScreen> createState() => _LoginPengayaanScreenState();
}

class _LoginPengayaanScreenState extends State<LoginPengayaanScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _sandi = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _sandi.dispose();
    super.dispose();
  }

  Future<void> _kirim() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final bool berhasil = await widget.controller.masuk(
      _email.text.trim(),
      _sandi.text,
    );
    if (berhasil && mounted) {
      _sandi.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool sibuk = widget.controller.sedangMemproses;
    final String? pesanGagal = widget.controller.pesanKesalahan;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengayaan — Multi Storage'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            const SizedBox(height: 8),
            const Text(
              'Portal Masuk Multi-Penyimpanan',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (pesanGagal != null) ...<Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  pesanGagal,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _email,
                    enabled: !sibuk,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.alternate_email_rounded),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => (val == null || val.trim().isEmpty)
                        ? 'Email wajib diisi'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  FieldKataSandi(
                    controller: _sandi,
                    enabled: !sibuk,
                    validator: (val) => (val == null || val.isEmpty)
                        ? 'Kata sandi wajib diisi'
                        : null,
                    onSubmitted: _kirim,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: FilledButton(
                onPressed: sibuk ? null : _kirim,
                child: sibuk
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Masuk'),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: sibuk
                  ? null
                  : () {
                      _email.text = AuthApi.emailDemo;
                      _sandi.text = AuthApi.sandiDemo;
                    },
              child: const Text('Gunakan Kredensial Demo'),
            ),
            const SizedBox(height: 20),
           PapanDiagnostikPenyimpanan(controller: widget.controller),
          ],
        ),
      ),
    );
  }
}