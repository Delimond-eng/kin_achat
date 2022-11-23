import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/utils/colors.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String title, hintText;
  final Color iconColor;
  final Color filledColor;
  final IconData icon;
  final Function(String value) onChanged;
  final Function(String d) onChangedCurrency;
  final bool isCurrency;
  final String selectedCurrency;
  final bool isDate;
  final Function(int value) onDatePicked;

  const InputField({
    Key key,
    this.controller,
    this.hintText,
    this.icon,
    this.title,
    this.iconColor,
    this.filledColor,
    this.onChanged,
    this.onChangedCurrency,
    this.isCurrency = false,
    this.selectedCurrency,
    this.isDate = false,
    this.onDatePicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currency = selectedCurrency ?? "USD";
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: filledColor ?? Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: iconColor ?? secondaryColor,
                    size: 18.0,
                  ),
                  Flexible(
                    child: TextField(
                      controller: controller,
                      onChanged: onChanged,
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        hintText: hintText,
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                        ),
                        border: InputBorder.none,
                        counterText: '',
                      ),
                    ),
                  ),
                  if (isCurrency) ...[
                    StatefulBuilder(builder: (context, setter) {
                      return SizedBox(
                        width: 70.0,
                        child: DropdownButton(
                          menuMaxHeight: 200,
                          dropdownColor: Colors.white,
                          alignment: Alignment.centerLeft,
                          borderRadius: BorderRadius.circular(5.0),
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          value: currency,
                          underline: const SizedBox(),
                          hint: Text(
                            "Devise",
                            style: GoogleFonts.poppins(
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          isExpanded: true,
                          items: ["USD", "CDF"].map((e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                                style: GoogleFonts.didactGothic(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                  color: Colors.grey[800],
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            onChangedCurrency(value);
                            setter(() {
                              currency = value;
                            });
                          },
                        ),
                      );
                    })
                  ]
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
