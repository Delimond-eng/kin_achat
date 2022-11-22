import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../components/cart_viewer.dart';
import '../utils/colors.dart';
import '../widgets/cart_openning_btn.dart';

class CommandesPage extends StatefulWidget {
  const CommandesPage({Key key}) : super(key: key);

  @override
  State<CommandesPage> createState() => _CommandesPageState();
}

class _CommandesPageState extends State<CommandesPage> {
  final GlobalKey<ScaffoldState> _sKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sKey,
      backgroundColor: Colors.grey[200],
      endDrawer: const CartViewer(),
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Lottie.asset("assets/lotties/empty-0.json"),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor,
            secondaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
      ),
      width: size.width,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mes commandes",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  CartOpenningBtn(
                    scaffoldKey: _sKey,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
