import 'package:flutter/material.dart';

class SharedPreferencesPage extends StatefulWidget {
  const SharedPreferencesPage({super.key});

  @override
  State<SharedPreferencesPage> createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  // Stored data
  String? savedName;
  int? savedAge;
  bool isDarkMode = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  // Simulasi SharedPreferences - Save data
  Future<void> saveData() async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nama tidak boleh kosong'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Simulasi delay
    await Future.delayed(Duration(milliseconds: 500));

    if (!mounted) return;

    // Dalam aplikasi nyata:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('name', nameController.text);
    // await prefs.setInt('age', int.tryParse(ageController.text) ?? 0);

    setState(() {
      savedName = nameController.text;
      savedAge = int.tryParse(ageController.text);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data berhasil disimpan!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Simulasi SharedPreferences - Load data
  Future<void> loadAllData() async {
    await Future.delayed(Duration(milliseconds: 300));

    if (!mounted) return;

    // Dalam aplikasi nyata:
    // final prefs = await SharedPreferences.getInstance();
    // String? name = prefs.getString('name');
    // int? age = prefs.getInt('age');
    // bool darkMode = prefs.getBool('darkMode') ?? false;
    // bool loggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      // Simulasi data yang sudah tersimpan
      savedName = savedName ?? 'InanTampan';
      savedAge = savedAge ?? 22;
      isDarkMode = isDarkMode;
      isLoggedIn = isLoggedIn;
    });
  }

  // Clear specific data
  Future<void> clearUserData() async {
    await Future.delayed(Duration(milliseconds: 300));

    if (!mounted) return;

    // Dalam aplikasi nyata:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('name');
    // await prefs.remove('age');

    setState(() {
      savedName = null;
      savedAge = null;
      nameController.clear();
      ageController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data user berhasil dihapus'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  // Clear all data
  Future<void> clearAllData() async {
    await Future.delayed(Duration(milliseconds: 300));

    if (!mounted) return;

    // Dalam aplikasi nyata:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    setState(() {
      savedName = null;
      savedAge = null;
      isDarkMode = false;
      isLoggedIn = false;
      nameController.clear();
      ageController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Semua data berhasil dihapus'),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Toggle dark mode
  Future<void> toggleDarkMode(bool value) async {
    // Dalam aplikasi nyata:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('darkMode', value);

    setState(() {
      isDarkMode = value;
    });
  }

  // Toggle login status
  Future<void> toggleLoginStatus(bool value) async {
    // Dalam aplikasi nyata:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('isLoggedIn', value);

    setState(() {
      isLoggedIn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pertemuan 13: Local Storage"), elevation: 4),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'SharedPreferences',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 8),
              Text(
                'Menyimpan data lokal di perangkat',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 24),

              // Info Box
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Data akan tetap tersimpan meskipun aplikasi ditutup',
                        style: TextStyle(fontSize: 13, color: Colors.blue[900]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Section 1: Save User Data
              _buildSection(
                title: '1. Simpan Data User',
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      hintText: 'Masukkan nama Anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      labelText: 'Umur',
                      hintText: 'Masukkan umur Anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.save),
                      label: Text('Simpan Data'),
                      onPressed: saveData,
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildCodeBox(
                    'final prefs = await SharedPreferences.getInstance();\n'
                    'await prefs.setString(\'name\', name);\n'
                    'await prefs.setInt(\'age\', age);',
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Section 2: Saved Data Display
              _buildSection(
                title: '2. Data Tersimpan',
                children: [
                  _buildDataRow(
                    icon: Icons.person,
                    label: 'Nama',
                    value: savedName ?? 'Belum ada data',
                    color: Colors.blue,
                  ),
                  SizedBox(height: 12),
                  _buildDataRow(
                    icon: Icons.cake,
                    label: 'Umur',
                    value: savedAge != null
                        ? '$savedAge tahun'
                        : 'Belum ada data',
                    color: Colors.green,
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: Icon(Icons.delete_outline),
                          label: Text('Hapus User'),
                          onPressed: clearUserData,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: Icon(Icons.delete_forever),
                          label: Text('Hapus Semua'),
                          onPressed: clearAllData,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _buildCodeBox(
                    'final prefs = await SharedPreferences.getInstance();\n'
                    'String? name = prefs.getString(\'name\');\n'
                    'int? age = prefs.getInt(\'age\');',
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Section 3: Preferences
              _buildSection(
                title: '3. Preferensi Aplikasi',
                children: [
                  SwitchListTile(
                    title: Text('Dark Mode'),
                    subtitle: Text(
                      isDarkMode ? 'Mode gelap aktif' : 'Mode terang aktif',
                    ),
                    value: isDarkMode,
                    onChanged: toggleDarkMode,
                    secondary: Icon(
                      isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: Colors.indigo,
                    ),
                  ),
                  Divider(),
                  SwitchListTile(
                    title: Text('Status Login'),
                    subtitle: Text(isLoggedIn ? 'Sudah login' : 'Belum login'),
                    value: isLoggedIn,
                    onChanged: toggleLoginStatus,
                    secondary: Icon(
                      isLoggedIn ? Icons.login : Icons.logout,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildCodeBox(
                    'await prefs.setBool(\'darkMode\', true);\n'
                    'bool? darkMode = prefs.getBool(\'darkMode\');',
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Section 4: Supported Data Types
              _buildSection(
                title: '4. Tipe Data yang Didukung',
                children: [
                  _buildTypeRow(
                    'String',
                    'setString() / getString()',
                    Colors.blue,
                  ),
                  SizedBox(height: 8),
                  _buildTypeRow('int', 'setInt() / getInt()', Colors.green),
                  SizedBox(height: 8),
                  _buildTypeRow(
                    'double',
                    'setDouble() / getDouble()',
                    Colors.orange,
                  ),
                  SizedBox(height: 8),
                  _buildTypeRow('bool', 'setBool() / getBool()', Colors.purple),
                  SizedBox(height: 8),
                  _buildTypeRow(
                    'List<String>',
                    'setStringList() / getStringList()',
                    Colors.red,
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Section 5: Use Cases
              _buildSection(
                title: '5. Contoh Penggunaan',
                children: [
                  _buildUseCaseCard(
                    icon: Icons.settings,
                    title: 'Pengaturan Aplikasi',
                    description:
                        'Simpan preferensi user seperti bahasa, tema, notifikasi',
                    color: Colors.blue,
                  ),
                  SizedBox(height: 12),
                  _buildUseCaseCard(
                    icon: Icons.login,
                    title: 'Status Login',
                    description:
                        'Simpan token autentikasi dan status login user',
                    color: Colors.green,
                  ),
                  SizedBox(height: 12),
                  _buildUseCaseCard(
                    icon: Icons.bookmark,
                    title: 'Cache Data',
                    description:
                        'Simpan data sementara untuk performa lebih baik',
                    color: Colors.orange,
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

  // Helper: Build section
  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
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

  // Helper: Build code box
  Widget _buildCodeBox(String code) {
    return Container(
      width: double.infinity,
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
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  // Helper: Build data row
  Widget _buildDataRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Build type row
  Widget _buildTypeRow(String type, String methods, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              type,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              methods,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Build use case card
  Widget _buildUseCaseCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }
}
