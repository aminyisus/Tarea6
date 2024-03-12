import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Amín Jesús Báez Espinosa 2021-0929

class GenderPredictionPage extends StatefulWidget {
  @override
  _GenderPredictionPageState createState() => _GenderPredictionPageState();
}

class _GenderPredictionPageState extends State<GenderPredictionPage> {
  TextEditingController _nameController = TextEditingController();
  String _gender = '';
  bool _isLoading = false;
  bool _errorOccurred = false;

  Future<void> predictGender(String name) async {
    setState(() {
      _isLoading = true;
      _errorOccurred = false;
    });

    if (name.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorOccurred = true;
      });
      return;
    }

    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _gender = data['gender'];
        _isLoading = false;
        _errorOccurred = false;
      });
    } else {
      setState(() {
        _gender = '';
        _isLoading = false;
        _errorOccurred = true;
      });
      throw Exception('Failed to predict gender');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Género'),
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
                Navigator.pop(context); // Cerrar el Drawer antes de navegar
                
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
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                errorText: _errorOccurred ? 'Por favor, ingresa un nombre válido' : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                predictGender(_nameController.text);
              },
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : _gender.isNotEmpty
                    ? Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _gender.toLowerCase() == 'male' ? Colors.blue : Colors.pink,
                        ),
                        child: Center(
                          child: Text(
                            _gender.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
