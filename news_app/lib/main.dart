// lib/main.dart
import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NewsHomePage(),
    );
  }
}

class NewsHomePage extends StatefulWidget {
  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  final ApiService _apiService = ApiService();
  List<dynamic> _articles = [];
  String _selectedCategory = 'general';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final articles = await _apiService.fetchNews(_selectedCategory);
      setState(() {
        _articles = articles;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _fetchNews();
    });
    Navigator.pop(context); // Close the drawer
  }

  Future<void> _onRefresh() async {
    await _fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News App')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Categories', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text('General'),
              onTap: () => _onCategorySelected('general'),
            ),
            ListTile(
              title: const Text('Business'),
              onTap: () => _onCategorySelected('business'),
            ),
            ListTile(
              title: const Text('Entertainment'),
              onTap: () => _onCategorySelected('entertainment'),
            ),
            ListTile(
              title: const Text('Health'),
              onTap: () => _onCategorySelected('health'),
            ),
            ListTile(
              title: const Text('Science'),
              onTap: () => _onCategorySelected('science'),
            ),
            ListTile(
              title: const Text('Sports'),
              onTap: () => _onCategorySelected('sports'),
            ),
            ListTile(
              title: const Text('Technology'),
              onTap: () => _onCategorySelected('technology'),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: _articles.length,
          itemBuilder: (context, index) {
            final article = _articles[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(article['title'] ?? 'No Title'),
                subtitle: Text(article['description'] ?? 'No Description'),
                onTap: () {
                  // Implement navigation to a detail view if needed
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
