import 'package:flutter/material.dart';

// Custom Theme Data
class CustomTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    primaryColor: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey[50],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      elevation: 2,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.indigo[900],
        fontFamily: 'Poppins',
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.indigo[800],
        fontFamily: 'Poppins',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black87,
        fontFamily: 'Roboto',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black54,
        fontFamily: 'Roboto',
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.indigo, width: 2),
        foregroundColor: Colors.indigo,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
    primaryColor: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[850],
      foregroundColor: Colors.white,
      elevation: 2,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.indigo[300],
        fontFamily: 'Poppins',
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.indigo[200],
        fontFamily: 'Poppins',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.white70,
        fontFamily: 'Roboto',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.white54,
        fontFamily: 'Roboto',
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.indigo, width: 2),
        foregroundColor: Colors.indigo[300],
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.grey[800],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

class StylingThemingPage extends StatefulWidget {
  const StylingThemingPage({super.key});

  @override
  State<StylingThemingPage> createState() => _StylingThemingPageState();
}

class _StylingThemingPageState extends State<StylingThemingPage> {
  late ThemeMode _currentThemeMode;

  @override
  void initState() {
    super.initState();
    _currentThemeMode = ThemeMode.system;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pertemuan 10: Styling & Theming"),
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(
              _currentThemeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              setState(() {
                if (_currentThemeMode == ThemeMode.dark) {
                  _currentThemeMode = ThemeMode.light;
                } else if (_currentThemeMode == ThemeMode.light) {
                  _currentThemeMode = ThemeMode.system;
                } else {
                  _currentThemeMode = ThemeMode.dark;
                }
              });
            },
            tooltip: 'Toggle Theme Mode',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Judul Besar dengan Custom Font
              Text(
                "Styling & Theming",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 8),
              Text(
                "Membuat UI yang konsisten dan menarik",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 24),

              // 2. Section: Text Styling
              _buildSection(
                context,
                title: "Text Styling",
                children: [
                  _buildTextExample(
                    context,
                    label: "Default Theme Text (Display Large)",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(height: 12),
                  _buildTextExample(
                    context,
                    label: "Title Large Style",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 12),
                  _buildTextExample(
                    context,
                    label: "Body Large Style",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 12),
                  _buildTextExample(
                    context,
                    label: "Body Medium Style",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(height: 24),

              // 3. Section: Custom Colors
              _buildSection(
                context,
                title: "Custom Colors",
                children: [
                  _buildColorCard(
                    context,
                    label: "Primary Color (Indigo)",
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 12),
                  _buildColorCard(
                    context,
                    label: "Success (Green)",
                    color: Colors.green,
                  ),
                  SizedBox(height: 12),
                  _buildColorCard(
                    context,
                    label: "Warning (Orange)",
                    color: Colors.orange,
                  ),
                  SizedBox(height: 12),
                  _buildColorCard(
                    context,
                    label: "Error (Red)",
                    color: Colors.red,
                  ),
                ],
              ),
              SizedBox(height: 24),

              // 4. Section: Button Styling
              _buildSection(
                context,
                title: "Button Styling",
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Elevated Button ditekan!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text("Elevated Button"),
                  ),
                  SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Outlined Button ditekan!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text("Outlined Button"),
                  ),
                  SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Text Button ditekan!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text("Text Button"),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // 5. Section: Card & Container Styling
              _buildSection(
                context,
                title: "Card Styling",
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Card Title",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Ini adalah contoh card dengan styling menggunakan ThemeData.",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // 6. Theme Mode Indicator
              _buildSection(
                context,
                title: "Theme Mode",
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.indigo, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Current Mode: ${_currentThemeMode == ThemeMode.system
                              ? 'System'
                              : _currentThemeMode == ThemeMode.dark
                              ? 'Dark'
                              : 'Light'}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Icon(
                          _currentThemeMode == ThemeMode.dark
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: Colors.indigo,
                        ),
                      ],
                    ),
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

  // Helper widget untuk menampilkan contoh text
  Widget _buildTextExample(
    BuildContext context, {
    required String label,
    required TextStyle? style,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text("Lorem ipsum dolor sit amet", style: style),
        ],
      ),
    );
  }

  // Helper widget untuk menampilkan contoh warna
  Widget _buildColorCard(
    BuildContext context, {
    required String label,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 4),
              Text(
                color.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
