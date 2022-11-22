import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/home_content.dart';

class PQtyUpdate extends StatelessWidget {
  final Function(int qty) onQuantityChanged;
  final Produit item;
  const PQtyUpdate({Key key, this.onQuantityChanged, this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int qty = item != null ? item.defaultQty : 1;
    return StatefulBuilder(builder: (context, setter) {
      return Row(
        children: [
          RoundedIconBtn(
            color: qty <= 1 ? Colors.grey[400] : Colors.indigo,
            icon: CupertinoIcons.minus,
            size: 25.0,
            onPressed: () async {
              if (qty > 1) {
                setter(() => qty--);
              }
              onQuantityChanged(qty);
            },
          ),
          const SizedBox(
            width: 4.0,
          ),
          Text(
            "$qty".padLeft(2, "0"),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          RoundedIconBtn(
            color: Colors.indigo,
            icon: CupertinoIcons.add,
            size: 25.0,
            onPressed: () async {
              setter(() => qty++);
              onQuantityChanged(qty);
            },
          ),
        ],
      );
    });
  }
}

class RoundedIconBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function onPressed;
  final double size;
  const RoundedIconBtn(
      {Key key, this.icon, this.color, this.onPressed, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 35.0,
      width: size ?? 35.0,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(35.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(35.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(40.0),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: size != null ? size - 15 : 15.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
