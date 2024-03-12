import 'package:flutter/material.dart';

//Amín Jesús Báez Espinosa 2021-0929

class ToolboxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToolBox App'),
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
                Navigator.pop(context); // Cerrar el Drawer antes de navegar
                
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
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Image.asset('assets/toolbox.jpg'),
      ),
    );
  }
}
