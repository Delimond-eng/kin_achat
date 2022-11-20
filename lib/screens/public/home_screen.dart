import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/global/controllers.dart';
import '../../controllers/auth_controller.dart';
import '../../pages/home_page.dart';
import '../../pages/profil_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const Center(child: Text('Page Favoris')),
    const ProfilePage(),
    const Center(child: Text('Page Commandes')),
  ];
  @override
  void initState() {
    googleSignIn.onCurrentUserChanged.listen((account) {
      if (_selectedPage == 2 && account == null) {
        setState(() => _selectedPage = 0);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _pages.elementAt(_selectedPage),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        selectedItemColor: Colors.indigo[800],
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.didactGothic(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w900,
        ),
        unselectedLabelStyle: GoogleFonts.didactGothic(
          fontWeight: FontWeight.w900,
          color: Colors.grey[600],
        ),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house), label: "Acceuil"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart), label: "Favoris"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), label: "Profil"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bag), label: "Commandes"),
        ],
        currentIndex: _selectedPage,
        onTap: _onPageChanged,
      ),
    );
  }

  void _onPageChanged(int index) {
    if (index == 2 && authController.currentUser == null) {
      setState(() => _selectedPage = 0);
      return;
    }
    setState(() {
      _selectedPage = index;
    });
  }
}
