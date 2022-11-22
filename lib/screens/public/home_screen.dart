import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/global/controllers.dart';
import 'package:kinachat/pages/commandes_page.dart';
import 'package:kinachat/pages/favorite_products.dart';
import 'package:kinachat/utils/colors.dart';
import '../../controllers/auth_controller.dart';
import '../../pages/home_page.dart';
import '../../pages/profil_page.dart';
import '../auth/authenticate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const FavoriteProducts(),
    const ProfilePage(),
    const CommandesPage(),
  ];
  @override
  void initState() {
    googleSignIn.onCurrentUserChanged.listen((account) {
      if ((_selectedPage == 1 || _selectedPage == 2 || _selectedPage == 3) &&
          account == null) {
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
        selectedItemColor: secondaryColor,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.poppins(
          color: secondaryColor,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
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
    if ((index == 1 || index == 2 || index == 3) &&
        authController.currentUser == null) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.grey[200],
        builder: (context) {
          return const Authenticate();
        },
      );
      setState(() => _selectedPage = 0);
      return;
    }
    setState(() {
      _selectedPage = index;
    });
  }
}
