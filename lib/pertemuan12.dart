import 'package:flutter/material.dart';

// Model class untuk parsing JSON
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  // Factory constructor untuk parsing JSON
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  // Convert object ke JSON
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'title': title, 'body': body};
  }
}

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  List<Post> posts = [];
  bool isLoading = false;
  String errorMessage = '';
  int currentTab = 0; // 0 = GET, 1 = POST

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  // GET Request - Mengambil data dari API
  Future<void> fetchPosts() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      // Simulasi GET request
      // Dalam aplikasi nyata, gunakan: import 'package:http/http.dart' as http;
      // final response = await http.get(
      //   Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      // );

      await Future.delayed(Duration(seconds: 2)); // Simulasi delay

      // Simulasi data dari API
      final List<Map<String, dynamic>> mockData = [
        {
          "userId": 1,
          "id": 1,
          "title": "Belajar Flutter",
          "body":
              "Flutter adalah framework untuk membuat aplikasi mobile, web, dan desktop.",
        },
        {
          "userId": 1,
          "id": 2,
          "title": "HTTP Request di Flutter",
          "body":
              "Gunakan package http untuk melakukan request ke server dan API.",
        },
        {
          "userId": 2,
          "id": 3,
          "title": "JSON Parsing",
          "body":
              "JSON parsing penting untuk mengolah data dari API menjadi object Dart.",
        },
        {
          "userId": 2,
          "id": 4,
          "title": "Model Class",
          "body":
              "Model class membantu struktur data dan membuat kode lebih mudah dimaintain.",
        },
        {
          "userId": 3,
          "id": 5,
          "title": "Async & Await",
          "body":
              "Async await digunakan untuk menangani operasi asynchronous seperti HTTP request.",
        },
      ];

      setState(() {
        posts = mockData.map((data) => Post.fromJson(data)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  // POST Request - Mengirim data ke server
  Future<void> sendPost() async {
    if (titleController.text.isEmpty || bodyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Judul dan body tidak boleh kosong'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Simulasi POST request
      // Dalam aplikasi nyata:
      // final response = await http.post(
      //   Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode({
      //     'userId': 1,
      //     'title': titleController.text,
      //     'body': bodyController.text,
      //   }),
      // );

      await Future.delayed(Duration(seconds: 2)); // Simulasi delay

      if (!mounted) return;

      final newPost = Post(
        id: posts.length + 1,
        userId: 1,
        title: titleController.text,
        body: bodyController.text,
      );

      setState(() {
        posts.insert(0, newPost);
        titleController.clear();
        bodyController.clear();
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post berhasil dibuat!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pertemuan 12: HTTP Request & API"),
        elevation: 4,
      ),
      body: isLoading && posts.isEmpty
          ? _buildLoadingView()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tabs
                    _buildTabs(),
                    SizedBox(height: 20),

                    // Content based on current tab
                    if (currentTab == 0) _buildGetRequestView(),
                    if (currentTab == 1) _buildPostRequestView(),
                  ],
                ),
              ),
            ),
    );
  }

  // Widget untuk tabs
  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentTab = 0;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: currentTab == 0 ? Colors.indigo : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'GET Request',
                    style: TextStyle(
                      color: currentTab == 0 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentTab = 1;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: currentTab == 1 ? Colors.indigo : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'POST Request',
                    style: TextStyle(
                      color: currentTab == 1 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk GET Request view
  Widget _buildGetRequestView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          'GET Request - Ambil Data dari API',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 12),

        // Info box
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
          ),
          child: Text(
            'GET request digunakan untuk mengambil data dari server. Data ditampilkan dalam ListView.',
            style: TextStyle(fontSize: 13, color: Colors.blue[900]),
          ),
        ),
        SizedBox(height: 16),

        // Code example
        Text('Contoh Code:', style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        _buildCodeBox(
          "final response = await http.get(\n"
          "  Uri.parse('https://jsonplaceholder.typicode.com/posts'),\n"
          ");\n\n"
          "if (response.statusCode == 200) {\n"
          "  List<dynamic> data = jsonDecode(response.body);\n"
          "  // Proses data\n"
          "}",
        ),
        SizedBox(height: 20),

        // Refresh button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            icon: Icon(Icons.refresh),
            label: Text('Refresh Data'),
            onPressed: isLoading ? null : fetchPosts,
          ),
        ),
        SizedBox(height: 16),

        // Data list
        Text(
          'Data dari API (${posts.length} posts)',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12),

        if (errorMessage.isNotEmpty)
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(errorMessage, style: TextStyle(color: Colors.red)),
          )
        else
          ...posts.map((post) => _buildPostCard(post)),
      ],
    );
  }

  // Widget untuk POST Request view
  Widget _buildPostRequestView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          'POST Request - Kirim Data ke API',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 12),

        // Info box
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
          ),
          child: Text(
            'POST request digunakan untuk mengirim data ke server. Isi form di bawah untuk membuat post baru.',
            style: TextStyle(fontSize: 13, color: Colors.green[900]),
          ),
        ),
        SizedBox(height: 16),

        // Code example
        Text('Contoh Code:', style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        _buildCodeBox(
          "final response = await http.post(\n"
          "  Uri.parse('https://jsonplaceholder.typicode.com/posts'),\n"
          "  headers: {'Content-Type': 'application/json'},\n"
          "  body: jsonEncode({'title': title, 'body': body}),\n"
          ");\n\n"
          "if (response.statusCode == 201) {\n"
          "  var newPost = Post.fromJson(jsonDecode(response.body));\n"
          "}",
        ),
        SizedBox(height: 20),

        // Form
        Text(
          'Form Buat Post Baru',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12),

        // Title input
        TextField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: 'Judul',
            hintText: 'Masukkan judul post',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          maxLines: 1,
        ),
        SizedBox(height: 12),

        // Body input
        TextField(
          controller: bodyController,
          decoration: InputDecoration(
            labelText: 'Isi',
            hintText: 'Masukkan isi post',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          maxLines: 4,
        ),
        SizedBox(height: 16),

        // Submit button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            icon: Icon(Icons.send),
            label: Text(isLoading ? 'Mengirim...' : 'Kirim Post'),
            onPressed: isLoading ? null : sendPost,
          ),
        ),
        SizedBox(height: 24),

        // Recent posts
        Text(
          'Post Terbaru (${posts.length})',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12),
        ...posts.take(5).map((post) => _buildPostCard(post)),
      ],
    );
  }

  // Widget untuk loading
  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Mengambil data dari API...'),
        ],
      ),
    );
  }

  // Widget untuk post card
  Widget _buildPostCard(Post post) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    post.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'ID: ${post.id}',
                    style: TextStyle(fontSize: 12, color: Colors.indigo),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              post.body,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Text(
              'User ID: ${post.userId}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk code box
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

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }
}
