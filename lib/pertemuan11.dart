import 'package:flutter/material.dart';

class AssetMediaPage extends StatefulWidget {
  const AssetMediaPage({super.key});

  @override
  State<AssetMediaPage> createState() => _AssetMediaPageState();
}

class _AssetMediaPageState extends State<AssetMediaPage> {
  String _audioStatus = "Tidak ada audio sedang diputar";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pertemuan 11: Asset & Media"), elevation: 4),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Mengelola Asset & Media",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 8),
              Text(
                "Gambar, Audio, dan Video di Flutter",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 24),

              // Section 1: Image Assets
              _buildSection(
                context,
                title: "1. Gambar dari Asset",
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 60, color: Colors.grey),
                        SizedBox(height: 12),
                        Text(
                          "Placeholder Gambar Asset",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "(assets/images/flutter_logo.png)",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Cara menggunakan gambar dari asset:",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  _buildCodeExample(
                    "Image.asset(\n"
                    "  'assets/images/flutter_logo.png',\n"
                    "  width: 100,\n"
                    "  height: 100,\n"
                    ")",
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Section 2: Network Image
              _buildSection(
                context,
                title: "2. Gambar dari Internet",
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.network(
                      'https://flutter.dev/images/flutter-logo-sharing.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Gagal memuat gambar",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Cara menggunakan gambar dari internet:",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  _buildCodeExample(
                    "Image.network(\n"
                    "  'https://example.com/image.png',\n"
                    "  width: 100,\n"
                    "  height: 100,\n"
                    ")",
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Section 3: Audio Player
              _buildSection(
                context,
                title: "3. Pemutar Audio",
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.indigo[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.indigo.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.music_note, color: Colors.indigo),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Audio Player",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    _audioStatus,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.play_arrow),
                                label: Text("Putar"),
                                onPressed: () {
                                  setState(() {
                                    _audioStatus =
                                        "Audio sedang diputar: sample.mp3";
                                  });
                                  _showAudioDialog();
                                },
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.pause),
                                label: Text("Pause"),
                                onPressed: () {
                                  setState(() {
                                    _audioStatus = "Audio dihentikan sementara";
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Gunakan package audioplayers:",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  _buildCodeExample(
                    "import 'package:audioplayers/audioplayers.dart';\n\n"
                    "AudioPlayer player = AudioPlayer();\n\n"
                    "await player.play(\n"
                    "  AssetSource('audio/sample.mp3'),\n"
                    ");",
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Section 4: Video Player
              _buildSection(
                context,
                title: "4. Pemutar Video",
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.videocam, size: 60, color: Colors.white),
                        SizedBox(height: 12),
                        Text(
                          "Placeholder Video",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "(assets/video/sample.mp4)",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.play_arrow),
                          label: Text("Putar"),
                          onPressed: () {
                            _showVideoDialog();
                          },
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.pause),
                          label: Text("Pause"),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Video dihentikan"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Gunakan package video_player:",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  _buildCodeExample(
                    "import 'package:video_player/video_player.dart';\n\n"
                    "_controller = VideoPlayerController.asset(\n"
                    "  'assets/video/sample.mp4',\n"
                    ")..initialize().then((_) {\n"
                    "  setState(() {});\n"
                    "});",
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Section 5: Asset Configuration
              _buildSection(
                context,
                title: "5. Konfigurasi di pubspec.yaml",
                children: [
                  _buildCodeExample(
                    "flutter:\n"
                    "  assets:\n"
                    "    - assets/images/\n"
                    "    - assets/audio/\n"
                    "    - assets/video/",
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange[300]!),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info, color: Colors.orange, size: 20),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Pastikan folder assets/images/, assets/audio/, dan assets/video/ sudah dibuat di root project.",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.orange[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Section 6: File Structure
              _buildSection(
                context,
                title: "6. Struktur Folder Asset",
                children: [
                  _buildCodeExample(
                    "project/\n"
                    "├── assets/\n"
                    "│   ├── images/\n"
                    "│   │   ├── flutter_logo.png\n"
                    "│   │   └── app_icon.png\n"
                    "│   ├── audio/\n"
                    "│   │   └── sample.mp3\n"
                    "│   └── video/\n"
                    "│       └── sample.mp4\n"
                    "├── lib/\n"
                    "├── pubspec.yaml\n"
                    "└── ...",
                  ),
                ],
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget untuk membuat section
  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.indigo.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.indigo.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ],
    );
  }

  // Helper widget untuk menampilkan code example
  Widget _buildCodeExample(String code) {
    return Container(
      padding: EdgeInsets.all(12),
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
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // Dialog untuk audio
  void _showAudioDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Memutar Audio"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.music_note, size: 50, color: Colors.indigo),
              SizedBox(height: 16),
              Text("Audio sedang diputar: sample.mp3"),
              SizedBox(height: 16),
              LinearProgressIndicator(value: 0.35),
              SizedBox(height: 8),
              Text(
                "0:35 / 1:00",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _audioStatus = "Audio sedang diputar: sample.mp3";
                });
                Navigator.pop(context);
              },
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  // Dialog untuk video
  void _showVideoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Memutar Video"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 250,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow, size: 50, color: Colors.white),
                    SizedBox(height: 12),
                    Text("sample.mp4", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              SizedBox(height: 16),
              LinearProgressIndicator(value: 0.45),
              SizedBox(height: 8),
              Text(
                "0:45 / 2:00",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }
}
