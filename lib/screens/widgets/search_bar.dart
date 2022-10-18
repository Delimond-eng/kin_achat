import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {
  final Function onFiltered;
  final TextEditingController controller;
  final String hintText;
  const SearchBar({
    Key key,
    this.controller,
    this.hintText,
    this.onFiltered,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 50.0,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.indigo[800].withOpacity(.8),
            blurRadius: 1.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              CupertinoIcons.search,
              color: Colors.grey[500],
            ),
            Flexible(
              child: TextField(
                //controller: widget.controller,
                style: GoogleFonts.didactGothic(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8.0),
                  hintText: hintText ?? "Recherche produit...",
                  hintStyle: GoogleFonts.didactGothic(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w800,
                    fontSize: 15.0,
                  ),
                  border: InputBorder.none,
                  counterText: '',
                ),
              ),
            ),
            Container(
              height: 50.0,
              width: 45.0,
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(.5),
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                  )
                ],
              ),
              child: Material(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5.0),
                  onTap: onFiltered,
                  child: const Center(
                    child: Icon(
                      Icons.filter_list_rounded,
                      color: Colors.white,
                      size: 18.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
