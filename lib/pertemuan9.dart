import 'package:flutter/material.dart';

class StudentRegistrationPage extends StatefulWidget {
  const StudentRegistrationPage({super.key});

  @override
  State<StudentRegistrationPage> createState() =>
      _StudentRegistrationPageState();
}

class _StudentRegistrationPageState extends State<StudentRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _fullName;
  String? _email;
  String? _major;
  bool _agree = false;

  // List of major options
  final List<String> _majors = [
    "Informatika",
    "Sistem Informasi",
    "Teknik Elektro",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pertemuan 9: Input & Form"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "Formulir Pendaftaran Mahasiswa",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 24),

                // 1. Input Nama Lengkap
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nama Lengkap",
                    hintText: "Masukkan nama lengkap Anda",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama lengkap wajib diisi";
                    }
                    if (value.length < 3) {
                      return "Nama minimal 3 karakter";
                    }
                    return null;
                  },
                  onSaved: (value) => _fullName = value,
                ),
                SizedBox(height: 20),

                // 2. Input Email dengan Validasi
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Masukkan email Anda",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email wajib diisi";
                    }
                    // Simple email validation
                    if (!value.contains("@")) {
                      return "Email harus mengandung @";
                    }
                    if (!value.contains(".")) {
                      return "Email harus mengandung titik (.)";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                      return "Format email tidak valid";
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value,
                ),
                SizedBox(height: 20),

                // 3. Dropdown Pilihan Jurusan
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Jurusan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.school),
                  ),
                  hint: Text("Pilih jurusan"),
                  initialValue: _major,
                  items: _majors
                      .map(
                        (major) =>
                            DropdownMenuItem(value: major, child: Text(major)),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _major = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Pilih salah satu jurusan";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // 4. Checkbox Persetujuan
                CheckboxListTile(
                  title: Text(
                    "Saya setuju dengan syarat dan ketentuan",
                    style: TextStyle(fontSize: 14),
                  ),
                  value: _agree,
                  onChanged: (value) {
                    setState(() {
                      _agree = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.blueAccent,
                ),
                SizedBox(height: 24),

                // 5. Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _agree) {
                        _formKey.currentState!.save();
                        _showSuccessSnackBar();
                      } else if (!_agree) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Anda harus menyetujui syarat dan ketentuan",
                            ),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method untuk menampilkan SnackBar dengan data yang tersimpan
  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "✓ Data Tersimpan",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text("Nama: $_fullName"),
            Text("Email: $_email"),
            Text("Jurusan: $_major"),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 4),
      ),
    );
  }
}
