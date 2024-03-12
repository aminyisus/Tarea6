import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Amín Jesús Báez Espinosa 2021-0929

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordpress News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/wordpress_news': (context) => WordpressNewsPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/wordpress_news');
          },
          child: Text('View Wordpress News'),
        ),
      ),
    );
  }
}

class WordpressNewsPage extends StatefulWidget {
  const WordpressNewsPage({Key? key}) : super(key: key);

  @override
  _WordpressNewsPageState createState() => _WordpressNewsPageState();
}

class _WordpressNewsPageState extends State<WordpressNewsPage> {
  late Future<List<dynamic>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = fetchNews();
  }

  Future<List<dynamic>> fetchNews() async {
    final response = await http.get(Uri.parse('https://blackamericaweb.com/wp-json/wp/v2/posts'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Black American Web News'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              title: Text('Caja de Herramientas'),
              onTap: () {
                Navigator.pushNamed(context, '/toolbox');
              },
            ),
            ListTile(
              title: Text('Predicción de Género'),
              onTap: () {
                Navigator.pushNamed(context, '/gender_prediction');
              },
            ),
            ListTile(
              title: Text('Determinación de Edad'),
              onTap: () {
                Navigator.pushNamed(context, '/age_determination');
              },
            ),
            ListTile(
              title: Text('Universidades por País'),
              onTap: () {
                Navigator.pushNamed(context, '/universities');
              },
            ),
            ListTile(
              title: Text('Clima en RD'),
              onTap: () {
                Navigator.pushNamed(context, '/weather');
              },
            ),
            ListTile(
              title: Text('Noticias de WordPress'),
              onTap: () {
                Navigator.pop(context); // Cerrar el Drawer antes de navegar
               
              },
            ),
            ListTile(
              title: Text('Acerca de'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final newsList = snapshot.data as List<dynamic>;
            return Column(
              children: [
                Image.asset(
                  'assets/logo.jpg',
                  height: 100, 
                  width: double.infinity, 
                  fit: BoxFit.cover, 
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      final news = newsList[index];
                      String imageUrl = '';
                      if (news.containsKey('_embedded') && news['_embedded'] != null) {
                        final embedded = news['_embedded'];
                        if (embedded.containsKey('wp:featuredmedia') && embedded['wp:featuredmedia'] != null) {
                          final featuredMedia = embedded['wp:featuredmedia'];
                          if (featuredMedia.isNotEmpty) {
                            final media = featuredMedia[0];
                            if (media.containsKey('source_url') && media['source_url'] != null) {
                              imageUrl = media['source_url'];
                            }
                          }
                        }
                      }
                      return ListTile(
                        title: Text(news['title']['rendered']),
                        leading: imageUrl.isNotEmpty ? Image.network(imageUrl) : null,
                        subtitle: Text(news['excerpt']['rendered']),
                        onTap: () {
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NewsDetailPage(news: news)),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class NewsDetailPage extends StatelessWidget {
  final dynamic news;

  const NewsDetailPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
    if (news.containsKey('_embedded') && news['_embedded'] != null) {
      final embedded = news['_embedded'];
      if (embedded.containsKey('wp:featuredmedia') && embedded['wp:featuredmedia'] != null) {
        final featuredMedia = embedded['wp:featuredmedia'];
        if (featuredMedia.isNotEmpty) {
          final media = featuredMedia[0];
          if (media.containsKey('source_url') && media['source_url'] != null) {
            imageUrl = media['source_url'];
          }
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(news['title']['rendered']),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          if (imageUrl.isNotEmpty) Image.network(imageUrl),
          const SizedBox(height: 16.0),
          Text(
            news['content']['rendered'],
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}