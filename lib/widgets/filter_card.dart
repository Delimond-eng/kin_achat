import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterBtn extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function onSelected;
  const FilterBtn({
    Key key,
    this.label,
    this.isSelected = false,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.indigo[200] : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            blurRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4.0),
          onTap: onSelected,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: isSelected
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                if (isSelected) ...[
                  Container(
                    height: 10.0,
                    width: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                ],
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: Colors.indigo[700],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
