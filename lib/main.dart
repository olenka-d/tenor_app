import 'package:flutter/material.dart';
import 'FavoriteGIFPage.dart';
import 'Home.dart';

void main() async {

  runApp(MaterialApp(
      home: Main()
  ));
}

class Main extends StatefulWidget {
  @override
  MainState createState() => MainState();
}

class MainState extends State<Main> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Home(),
    FavoriteGIFPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Tenor картинки'),
          backgroundColor: Colors.green,
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedItemColor: Colors.green,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Головна',

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Улюблені',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Налаштування',
              ),
            ]
        )
    );
  }
}

