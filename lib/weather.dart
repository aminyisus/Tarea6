import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Amín Jesús Báez Espinosa 2021-0929

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String _apiKey = '66810416595445a0a6720817240603'; 
  String _city = 'Santo Domingo'; 
  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;
  bool _errorOccurred = false;

  Future<void> fetchWeather() async {
    setState(() {
      _isLoading = true;
      _errorOccurred = false;
    });

    final response = await http.get(Uri.parse('https://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$_city'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _weatherData = data;
        _isLoading = false;
        _errorOccurred = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        _errorOccurred = true;
      });
      throw Exception('Failed to fetch weather data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima'),
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
                Navigator.pushNamed(context, '/universities');
              },
            ),
            ListTile(
              title: Text('Clima en RD'),
              onTap: () {
                Navigator.pop(context); // Cerrar el Drawer antes de navegar
                
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
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _weatherData != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ciudad: ${_weatherData!['location']['name']}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Temperatura: ${_weatherData!['current']['temp_c']}°C',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Humedad: ${_weatherData!['current']['humidity']}%',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Velocidad del viento: ${_weatherData!['current']['wind_kph']} km/h',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  )
                : _errorOccurred
                    ? Center(child: Text('Error al cargar datos del clima'))
                    : Center(child: Text('No se encontraron datos del clima')),
      ),
    );
  }
}
