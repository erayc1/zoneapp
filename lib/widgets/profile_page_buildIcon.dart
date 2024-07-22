import 'package:flutter/material.dart';

Widget buildIcon(IconData icon, Color color) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
        ),
      ],
    ),
    child: IconButton(
      icon: Icon(
        icon,
        color: color,
        size: 40,
      ),
      onPressed: () {},
    ),
  );
}
