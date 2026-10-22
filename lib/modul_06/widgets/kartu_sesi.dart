import 'package:flutter/material.dart';
import '../models/sesi_pengguna.dart';

class KartuSesi extends StatelessWidget {
  final SesiPengguna sesi;
  final DateTime sekarang;
  final VoidCallback onKeluar;
  final bool sedangKeluar;

  const KartuSesi({
    super.key,
    required this.sesi,
    required this.sekarang,
    required this.onKeluar,
    this.sedangKeluar = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool kedaluwarsa = sesi.sudahKedaluwarsa(sekarang);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Text(
                    sesi.nama.isNotEmpty ? sesi.nama[0].toUpperCase() : '?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        sesi.nama,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        sesi.email,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _barisInfo('Peran', sesi.peran),
            const SizedBox(height: 8),
            _barisInfo('Token', sesi.token),
            const SizedBox(height: 8),
            _barisInfo(
              'Status Sesi',
              kedaluwarsa ? 'Kedaluwarsa' : 'Aktif',
              warna: kedaluwarsa ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonal(
                onPressed: sedangKeluar ? null : onKeluar,
                child: sedangKeluar
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Keluar dari Akun'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _barisInfo(String label, String nilai, {Color? warna}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
        const Text(': '),
        Expanded(
          child: Text(
            nilai,
            style: TextStyle(fontSize: 13, color: warna),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}