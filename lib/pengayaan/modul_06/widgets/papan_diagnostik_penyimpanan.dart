import 'package:flutter/material.dart';
import '../../../modul_06/services/sesi_memori.dart';
import '../controllers/sesi_controller.dart';
import '../repositories/aman_sesi_repository.dart';
import '../repositories/memori_sesi_repository.dart';
import '../repositories/prefs_sesi_repository.dart';
import '../repositories/sesi_repository.dart';
import '../storage/penyimpanan_aman_platform.dart';

class PapanDiagnostikPenyimpanan extends StatefulWidget {
  final SesiController controller;

  const PapanDiagnostikPenyimpanan({super.key, required this.controller});

  @override
  State<PapanDiagnostikPenyimpanan> createState() =>
      _PapanDiagnostikPenyimpananState();
}

class _PapanDiagnostikPenyimpananState
    extends State<PapanDiagnostikPenyimpanan> {
  String _isiSharedPreferences = '-';
  String _isiSecureStorage = '-';
  bool _sedangMemuat = false;

  Future<void> _intipData() async {
    setState(() => _sedangMemuat = true);

    try {
      final PrefsSesiRepository prefsRepo = PrefsSesiRepository();
      const AmanSesiRepository secureRepo =
          AmanSesiRepository(PenyimpananAmanPlatform());

      final String? prefsData = await prefsRepo.intipMentah();
      final String? secureData = await secureRepo.intipMentah();

      if (!mounted) return;
      setState(() {
        _isiSharedPreferences = prefsData ?? '(kosong)';
        _isiSecureStorage = secureData ?? '(kosong)';
        _sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isiSharedPreferences = 'Gagal membaca: $e';
        _isiSecureStorage = 'Gagal membaca: $e';
        _sedangMemuat = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final SesiRepository repositoryAktif = widget.controller.repository;

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Diagnostik & Penukar Penyimpanan',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Aktif: ${repositoryAktif.namaStrategi}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                ChoiceChip(
                  label: const Text('Memori', style: TextStyle(fontSize: 11)),
                  selected: repositoryAktif is MemoriSesiRepository,
                  onSelected: (bool selected) {
                    if (selected && repositoryAktif is! MemoriSesiRepository) {
                      widget.controller.gantiStrategiPenyimpanan(
                        MemoriSesiRepository(SesiMemori()),
                      );
                    }
                  },
                ),
                ChoiceChip(
                  label: const Text('Prefs (Plaintext)',
                      style: TextStyle(fontSize: 11)),
                  selected: repositoryAktif is PrefsSesiRepository,
                  onSelected: (bool selected) {
                    if (selected && repositoryAktif is! PrefsSesiRepository) {
                      widget.controller
                          .gantiStrategiPenyimpanan(PrefsSesiRepository());
                    }
                  },
                ),
                ChoiceChip(
                  label: const Text('Secure Storage',
                      style: TextStyle(fontSize: 11)),
                  selected: repositoryAktif is AmanSesiRepository,
                  onSelected: (bool selected) {
                    if (selected && repositoryAktif is! AmanSesiRepository) {
                      widget.controller.gantiStrategiPenyimpanan(
                        const AmanSesiRepository(PenyimpananAmanPlatform()),
                      );
                    }
                  },
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: <Widget>[
                const Text(
                  'Intip Penyimpanan Fisik',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: _sedangMemuat ? null : _intipData,
                  icon: const Icon(Icons.refresh_rounded, size: 16),
                  label: const Text('Periksa', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            _tampilkanNilai('SharedPreferences', _isiSharedPreferences),
            const SizedBox(height: 6),
            _tampilkanNilai('SecureStorage', _isiSecureStorage),
          ],
        ),
      ),
    );
  }

  Widget _tampilkanNilai(String label, String nilai) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Text(
            nilai,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 10),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}