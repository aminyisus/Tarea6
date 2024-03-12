import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Amín Jesús Báez Espinosa 2021-0929

class AgeDeterminationPage extends StatefulWidget {
  @override
  _AgeDeterminationPageState createState() => _AgeDeterminationPageState();
}

class _AgeDeterminationPageState extends State<AgeDeterminationPage> {
  TextEditingController _nameController = TextEditingController();
  int _age = 0;
  String _ageGroup = '';
  bool _isLoading = false;
  bool _errorOccurred = false;

  Future<void> determineAge(String name) async {
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

    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _age = data['age'];
        _isLoading = false;
        _errorOccurred = false;

        if (_age < 18) {
          _ageGroup = 'Joven';
        } else if (_age >= 18 && _age < 60) {
          _ageGroup = 'Adulto';
        } else {
          _ageGroup = 'Anciano';
        }
      });
    } else {
      setState(() {
        _age = 0;
        _isLoading = false;
        _errorOccurred = true;
      });
      throw Exception('Failed to determine age');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Determinación de Edad'),
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
                Navigator.pop(context); // Cerrar el Drawer antes de navegar
                
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
                determineAge(_nameController.text);
              },
              child: Text('Determinar Edad'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : _age > 0
                    ? Column(
                        children: [
                          Text(
                            'Edad: $_age',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Grupo de Edad: $_ageGroup',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          _ageGroup == 'Joven'
                              ? Image.asset('assets/bebe.jpg', width: 150, height: 150)
                              : _ageGroup == 'Adulto'
                                  ? Image.asset('assets/adulto.jpg', width: 150, height: 150)
                                  : Image.asset('assets/anciano.jpg', width: 150, height: 150),
                        ],
                      )
                    : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
