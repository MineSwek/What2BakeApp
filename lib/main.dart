import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:what2bake/pages/favorites.dart';
import 'package:what2bake/pages/home.dart';
import 'package:what2bake/pages/recipes.dart';
import 'package:what2bake/pages/ingredients.dart';
import 'package:what2bake/pages/profile.dart';
import 'package:what2bake/pages/login.dart';

void main() async {
  await initHiveForFlutter();
  runApp(const MaterialApp(home: MainWindow(),));
}

class MainWindow extends StatefulWidget {
  const MainWindow({Key? key}) : super(key: key);

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {

  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    Home(),
    Recipes(),
    Ingredients(),
    Favorites(),
    Profile(),
    Login(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'Recipes',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.kitchen),
              label: 'Ingredients',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
          ),
        ],

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF272727),
        selectedItemColor: Colors.amber,
        unselectedItemColor: const Color(0xFFBBBBBB),
      ),
    );
  }
}




