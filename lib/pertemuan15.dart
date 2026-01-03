import 'package:flutter/material.dart';

class BuildDeployPage extends StatelessWidget {
  const BuildDeployPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertemuan 15: Build & Deployment'),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Build APK & Deployment',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Mempersiapkan aplikasi Flutter untuk distribusi',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              _section(
                context,
                title: '1. Perbedaan Debug vs Release',
                children: [
                  _infoRow(
                    icon: Icons.bug_report,
                    title: 'Debug Build',
                    description:
                        'Untuk pengembangan, lebih besar & lambat, mendukung hot-reload/logging.',
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 8),
                  _infoRow(
                    icon: Icons.verified,
                    title: 'Release Build',
                    description:
                        'Untuk distribusi, dioptimalkan, tanpa tooling debug, ukuran lebih kecil.',
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _section(
                context,
                title: '2. Build APK',
                children: [
                  const Text('Debug (cek cepat di device):'),
                  const SizedBox(height: 8),
                  _codeBox('flutter build apk --debug'),
                  const SizedBox(height: 12),
                  const Text('Release (siap distribusi):'),
                  const SizedBox(height: 8),
                  _codeBox('flutter build apk --release'),
                  const SizedBox(height: 12),
                  const Text('Split-per-ABI (APK lebih kecil per arsitektur):'),
                  const SizedBox(height: 8),
                  _codeBox('flutter build apk --split-per-abi'),
                ],
              ),
              const SizedBox(height: 20),

              _section(
                context,
                title: '3. Build App Bundle (AAB)',
                children: [
                  const Text(
                    'Format resmi Play Store, unggah ke Google Play Console:',
                  ),
                  const SizedBox(height: 8),
                  _codeBox('flutter build appbundle --release'),
                  const SizedBox(height: 8),
                  const Text(
                    'Output: build/app/outputs/bundle/release/app-release.aab',
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _section(
                context,
                title: '4. Signing Release',
                children: [
                  const Text('Buat keystore (sekali saja):'),
                  const SizedBox(height: 8),
                  _codeBox(
                    'keytool -genkey -v -keystore ~/my-key.jks \\ \n'
                    '  -keyalg RSA -keysize 2048 -validity 10000 -alias my-key',
                  ),
                  const SizedBox(height: 12),
                  const Text('Isi android/key.properties:'),
                  const SizedBox(height: 8),
                  _codeBox(
                    'storePassword=<password>\n'
                    'keyPassword=<password>\n'
                    'keyAlias=my-key\n'
                    'storeFile=../my-key.jks',
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Pastikan gradle app membaca key.properties (android/app/build.gradle).',
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _section(
                context,
                title: '5. Workflow Sederhana',
                children: [
                  _checkItem(
                    'Kembangkan & uji di debug build (emulator/device).',
                  ),
                  _checkItem('Bangun release APK/AAB.'),
                  _checkItem('Pastikan signing release sudah benar.'),
                  _checkItem(
                    'Distribusi: APK (sideload) atau AAB (Play Store).',
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _section(
                context,
                title: '6. Tugas Praktik',
                children: const [
                  Text(
                    '1) Build APK release, install di device, bandingkan ukuran & performa dengan debug.',
                  ),
                  SizedBox(height: 8),
                  Text(
                    '2) Coba build AAB untuk simulasi upload ke Play Store.',
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _section(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.indigo.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.indigo.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }

  static Widget _codeBox(String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.green[300],
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  static Widget _infoRow({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _checkItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 18),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
      ],
    );
  }
}
