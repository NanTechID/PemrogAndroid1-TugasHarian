import 'package:flutter/material.dart';
import 'secondpage.dart';
import 'thirdpage.dart';
import 'fourthpage.dart';
import 'fifthpage.dart';
import 'themes.dart';
import 'pertemuan9.dart';
import 'pertemuan10.dart';
import 'pertemuan11.dart';
import 'pertemuan12.dart';
import 'pertemuan13.dart';
import 'pertemuan14.dart';
import 'pertemuan15.dart';

// Global theme mode controller. Default to system.
final ValueNotifier<ThemeMode> appThemeMode = ValueNotifier(ThemeMode.system);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeMode,
      builder: (context, mode, child) {
        return MaterialApp(
          title: 'Pertemuan Flutter',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: mode,
          home: const MyHomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Counter: $_counter', style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        ElevatedButton(onPressed: _increment, child: Text('Increment')),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pertemuan 3'),
        actions: [
          IconButton(icon: Icon(Icons.info), onPressed: () {}),
          // Theme toggle
          ValueListenableBuilder<ThemeMode>(
            valueListenable: appThemeMode,
            builder: (context, mode, child) {
              final isDark = mode == ThemeMode.dark;
              return IconButton(
                tooltip: isDark ? 'Ubah ke mode terang' : 'Ubah ke mode gelap',
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  // Toggle between light and dark. If currently system, switch to dark.
                  if (appThemeMode.value == ThemeMode.dark) {
                    appThemeMode.value = ThemeMode.light;
                  } else {
                    appThemeMode.value = ThemeMode.dark;
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          // agar bisa discroll jika konten banyak
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello, INAN! Saya Gibaran Raka Buming Raka!',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Gibran_Rakabuming_2024_official_portrait.jpg/500px-Gibran_Rakabuming_2024_official_portrait.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Icon(Icons.star, color: Colors.amber, size: 50),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('ElevatedButton ditekan');
                  },
                  child: Text('Tekan Saya'),
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 12),
                // Tombol navigasi ke halaman lain — tampil rapi dan konsisten
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 560),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(48),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyLayoutPage(),
                            ),
                          );
                        },
                        child: Text('Ke Halaman Layout Dasar (Pertemuan 4)'),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(48),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyAdvancedWidgetsPage(),
                            ),
                          );
                        },
                        child: Text('Ke Halaman Widget Lanjutan (Pertemuan 5)'),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(48),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FirstPage(),
                            ),
                          );
                        },
                        child: Text('Ke Halaman Navigasi Data (Pertemuan 6)'),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(48),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StateExample(),
                            ),
                          );
                        },
                        child: Text('Ke Halaman Stateful Widget (Pertemuan 7)'),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(48),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentRegistrationPage(),
                            ),
                          );
                        },
                        child: Text('Ke Halaman Input & Form (Pertemuan 8)'),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(48),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StylingThemingPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Ke Halaman Styling & Theming (Pertemuan 10)',
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(48),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssetMediaPage(),
                            ),
                          );
                        },
                        child: Text('Ke Halaman Asset & Media (Pertemuan 11)'),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(48),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ApiPage()),
                          );
                        },
                        child: Text(
                          'Ke Halaman HTTP Request & API (Pertemuan 12)',
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(48),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SharedPreferencesPage(),
                            ),
                          );
                        },
                        child: Text('Ke Halaman Local Storage (Pertemuan 13)'),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(48),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SQLitePage(),
                            ),
                          );
                        },
                        child: Text(
                          'Ke Halaman Database SQLite (Pertemuan 14)',
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(48),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BuildDeployPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Ke Halaman Build & Deployment (Pertemuan 15)',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
