import 'package:flutter/material.dart';

//Amín Jesús Báez Espinosa 2021-0929

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
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
                Navigator.pop(context); // Cerrar el Drawer antes de navegar
                
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/amin.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              'Amín Jesús Báez Espinosa',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            ContactInformation(
              email: 'baezamin580@gmail.com',
              github: 'aminyisus',
              linkedin: 'Amín Jesús Báez Espinosa',
              phone: '+1(829)-669-0027',
            ),
          ],
        ),
      ),
    );
  }
}

class ContactInformation extends StatelessWidget {
  final String email;
  final String github;
  final String linkedin;
  final String phone;

  const ContactInformation({
    required this.email,
    required this.github,
    required this.linkedin,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Correo: $email',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          'GitHub: $github',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          'LinkedIn: $linkedin',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          'Celular: $phone',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
