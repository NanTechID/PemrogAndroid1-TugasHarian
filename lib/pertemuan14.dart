import 'package:flutter/material.dart';

// Model class untuk User
class User {
  final int? id;
  final String name;
  final int age;
  final String major;

  User({this.id, required this.name, required this.age, required this.major});

  // Convert User object ke Map
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age, 'major': major};
  }

  // Convert Map ke User object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      major: map['major'],
    );
  }
}

class SQLitePage extends StatefulWidget {
  const SQLitePage({super.key});

  @override
  State<SQLitePage> createState() => _SQLitePageState();
}

class _SQLitePageState extends State<SQLitePage> {
  List<User> users = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController majorController = TextEditingController();

  User? editingUser;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  // Simulasi initDB dan load users
  Future<void> loadUsers() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(milliseconds: 500));

    if (!mounted) return;

    // Dalam aplikasi nyata:
    // final db = await database;
    // final List<Map<String, dynamic>> maps = await db.query('users');
    // List<User> loadedUsers = List.generate(maps.length, (i) {
    //   return User.fromMap(maps[i]);
    // });

    setState(() {
      // Data contoh
      if (users.isEmpty) {
        users = [
          User(id: 1, name: 'Tubagus Ahmad', age: 22, major: 'Informatika'),
          User(
            id: 2,
            name: 'Siti Nurhaliza',
            age: 21,
            major: 'Sistem Informasi',
          ),
          User(id: 3, name: 'Budi Santoso', age: 23, major: 'Teknik Elektro'),
        ];
      }
      isLoading = false;
    });
  }

  // CREATE - Insert User
  Future<void> insertUser() async {
    if (nameController.text.isEmpty ||
        ageController.text.isEmpty ||
        majorController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Semua field harus diisi!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(milliseconds: 500));

    if (!mounted) return;

    // Dalam aplikasi nyata:
    // final db = await database;
    // await db.insert(
    //   'users',
    //   user.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );

    final newUser = User(
      id: users.isEmpty
          ? 1
          : users.map((u) => u.id!).reduce((a, b) => a > b ? a : b) + 1,
      name: nameController.text,
      age: int.parse(ageController.text),
      major: majorController.text,
    );

    setState(() {
      users.add(newUser);
      isLoading = false;
    });

    clearForm();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data berhasil ditambahkan!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // UPDATE - Update User
  Future<void> updateUser() async {
    if (editingUser == null) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(milliseconds: 500));

    if (!mounted) return;

    // Dalam aplikasi nyata:
    // final db = await database;
    // await db.update(
    //   'users',
    //   user.toMap(),
    //   where: 'id = ?',
    //   whereArgs: [user.id],
    // );

    final updatedUser = User(
      id: editingUser!.id,
      name: nameController.text,
      age: int.parse(ageController.text),
      major: majorController.text,
    );

    setState(() {
      final index = users.indexWhere((u) => u.id == editingUser!.id);
      if (index != -1) {
        users[index] = updatedUser;
      }
      isLoading = false;
    });

    clearForm();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data berhasil diupdate!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  // DELETE - Delete User
  Future<void> deleteUser(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Apakah Anda yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(milliseconds: 500));

    if (!mounted) return;

    // Dalam aplikasi nyata:
    // final db = await database;
    // await db.delete(
    //   'users',
    //   where: 'id = ?',
    //   whereArgs: [id],
    // );

    setState(() {
      users.removeWhere((u) => u.id == id);
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data berhasil dihapus!'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  // Set form untuk edit
  void setEditMode(User user) {
    setState(() {
      editingUser = user;
      nameController.text = user.name;
      ageController.text = user.age.toString();
      majorController.text = user.major;
    });
  }

  // Clear form
  void clearForm() {
    setState(() {
      editingUser = null;
      nameController.clear();
      ageController.clear();
      majorController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pertemuan 14: SQLite CRUD"), elevation: 4),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Database SQLite',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'CRUD Operations dengan sqflite',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 24),

                  // Info Box
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.purple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.purple.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.storage, color: Colors.purple),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'SQLite: Database lokal untuk data terstruktur',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.purple[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),

                  // Form Section
                  _buildSection(
                    title: editingUser == null
                        ? '1. CREATE - Tambah Data'
                        : '3. UPDATE - Edit Data',
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Nama Lengkap',
                          hintText: 'Masukkan nama',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: ageController,
                              decoration: InputDecoration(
                                labelText: 'Umur',
                                hintText: 'Umur',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                prefixIcon: Icon(Icons.cake),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: majorController,
                              decoration: InputDecoration(
                                labelText: 'Jurusan',
                                hintText: 'Jurusan',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                prefixIcon: Icon(Icons.school),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton.icon(
                                icon: Icon(
                                  editingUser == null ? Icons.add : Icons.save,
                                ),
                                label: Text(
                                  editingUser == null ? 'Tambah' : 'Update',
                                ),
                                onPressed: editingUser == null
                                    ? insertUser
                                    : updateUser,
                              ),
                            ),
                          ),
                          if (editingUser != null) ...[
                            SizedBox(width: 12),
                            SizedBox(
                              height: 48,
                              child: OutlinedButton.icon(
                                icon: Icon(Icons.cancel),
                                label: Text('Batal'),
                                onPressed: clearForm,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (editingUser == null) ...[
                        SizedBox(height: 12),
                        _buildCodeBox(
                          'await db.insert(\n'
                          '  \'users\',\n'
                          '  user.toMap(),\n'
                          '  conflictAlgorithm: ConflictAlgorithm.replace,\n'
                          ');',
                        ),
                      ] else ...[
                        SizedBox(height: 12),
                        _buildCodeBox(
                          'await db.update(\n'
                          '  \'users\',\n'
                          '  user.toMap(),\n'
                          '  where: \'id = ?\',\n'
                          '  whereArgs: [user.id],\n'
                          ');',
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 24),

                  // List Section
                  _buildSection(
                    title: '2. READ - Daftar Mahasiswa (${users.length})',
                    children: [
                      _buildCodeBox(
                        'final List<Map<String, dynamic>> maps = \n'
                        '  await db.query(\'users\');\n'
                        'List<User> users = List.generate(maps.length, (i) {\n'
                        '  return User.fromMap(maps[i]);\n'
                        '});',
                      ),
                      SizedBox(height: 16),
                      if (users.isEmpty)
                        Container(
                          padding: EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Icon(Icons.inbox, size: 60, color: Colors.grey),
                              SizedBox(height: 12),
                              Text(
                                'Belum ada data mahasiswa',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      else
                        ...users.map((user) => _buildUserCard(user)),
                    ],
                  ),
                  SizedBox(height: 24),

                  // CRUD Operations Info
                  _buildSection(
                    title: '4. Operasi CRUD',
                    children: [
                      _buildCRUDCard(
                        icon: Icons.add_circle,
                        title: 'CREATE (Insert)',
                        description: 'Menambahkan data baru ke database',
                        color: Colors.green,
                        method: 'db.insert()',
                      ),
                      SizedBox(height: 8),
                      _buildCRUDCard(
                        icon: Icons.search,
                        title: 'READ (Select)',
                        description: 'Membaca/mengambil data dari database',
                        color: Colors.blue,
                        method: 'db.query()',
                      ),
                      SizedBox(height: 8),
                      _buildCRUDCard(
                        icon: Icons.edit,
                        title: 'UPDATE',
                        description: 'Mengupdate data yang sudah ada',
                        color: Colors.orange,
                        method: 'db.update()',
                      ),
                      SizedBox(height: 8),
                      _buildCRUDCard(
                        icon: Icons.delete,
                        title: 'DELETE',
                        description: 'Menghapus data dari database',
                        color: Colors.red,
                        method: 'db.delete()',
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  // Database Schema
                  _buildSection(
                    title: '5. Database Schema',
                    children: [
                      _buildCodeBox(
                        'CREATE TABLE users(\n'
                        '  id INTEGER PRIMARY KEY AUTOINCREMENT,\n'
                        '  name TEXT,\n'
                        '  age INTEGER,\n'
                        '  major TEXT\n'
                        ')',
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Memproses...'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
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

  // Helper: Build user card
  Widget _buildUserCard(User user) {
    final isEditing = editingUser?.id == user.id;

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: isEditing ? 4 : 1,
      color: isEditing ? Colors.blue.withValues(alpha: 0.1) : null,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              backgroundColor: Colors.indigo.withValues(alpha: 0.2),
              child: Text(
                user.name[0].toUpperCase(),
                style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.cake, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        '${user.age} tahun',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.school, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          user.major,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'ID: ${user.id}',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ),
            // Actions
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, size: 20),
                  color: Colors.blue,
                  onPressed: () => setEditMode(user),
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: Icon(Icons.delete, size: 20),
                  color: Colors.red,
                  onPressed: () => deleteUser(user.id!),
                  tooltip: 'Hapus',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper: Build CRUD card
  Widget _buildCRUDCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required String method,
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
                SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    method,
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'monospace',
                      color: Colors.grey[700],
                    ),
                  ),
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
    majorController.dispose();
    super.dispose();
  }
}
