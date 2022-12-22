import 'package:flutter/material.dart';
import 'package:what2bake/pages/favorites.dart';
import 'package:what2bake/pages/home.dart';
import 'package:what2bake/pages/recipes.dart';
import 'package:what2bake/pages/ingredients.dart';
import 'package:what2bake/pages/profile.dart';
import 'package:what2bake/pages/login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  runApp(const MaterialApp(home: MainWindow()));
}

class MainWindow extends StatefulWidget {
  const MainWindow({Key? key}) : super(key: key);

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  late Future recipes;
  late Future ingredients;

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
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/house.svg"),
              label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/cookbook.svg"),
              label: 'Przepisy',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/breakfast.svg"),
              label: 'Składniki',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/favorite.svg"),
              label: 'Ulubione',
          ),
        ],

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF272727),
        selectedLabelStyle: GoogleFonts.montserrat(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          )
        ),
        showUnselectedLabels: false,
        selectedItemColor: Colors.amber,
        unselectedItemColor: const Color(0xFFBBBBBB),
      ),
    );
  }
}




