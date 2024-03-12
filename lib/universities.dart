import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Amín Jesús Báez Espinosa 2021-0929

class UniversitiesPage extends StatefulWidget {
  @override
  _UniversitiesPageState createState() => _UniversitiesPageState();
}

class _UniversitiesPageState extends State<UniversitiesPage> {
  TextEditingController _countryController = TextEditingController();
  List<dynamic> _universities = [];
  bool _isLoading = false;
  bool _errorOccurred = false;
  String _errorMessage = '';

  Future<void> fetchUniversities(String country) async {
    setState(() {
      _isLoading = true;
      _errorOccurred = false;
    });

    try {
      final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _universities = data;
          _isLoading = false;
          _errorOccurred = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorOccurred = true;
          _errorMessage = 'Error al obtener universidades';
        });
        throw Exception('Failed to fetch universities');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorOccurred = true;
        _errorMessage = 'País no encontrado o ingresado en otro idioma';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades por País'),
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
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
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
                Navigator.pop(context); // Cerrar el Drawer antes de navegar
                
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
                Navigator.pushNamed(context, '/wordpress_news');
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: 'País (en inglés)',
                errorText: _errorOccurred ? _errorMessage : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchUniversities(_countryController.text);
              },
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : _universities.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _universities.length,
                          itemBuilder: (context, index) {
                            final university = _universities[index];
                            return ListTile(
                              title: Text(university['name']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Dominio: ${university['domains'].isEmpty ? 'No disponible' : university['domains'][0]}'),
                                  Text('Página web: ${university['web_pages'].isEmpty ? 'No disponible' : university['web_pages'][0]}'),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
