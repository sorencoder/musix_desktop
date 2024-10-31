import 'package:flutter/material.dart';

Color hexToColor(String hexColor) {
  // Check if hexColor is null or empty
  if (hexColor.isEmpty ||
      !RegExp(r'^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$').hasMatch(hexColor)) {
    return Colors.grey; // Return a default color if the hex code is invalid
  }

  // Parse the hex color string
  final buffer = StringBuffer();
  if (hexColor.length == 7) buffer.write('ff'); // Add alpha if missing
  buffer.write(hexColor.replaceFirst('#', ''));

  return Color(int.parse(buffer.toString(), radix: 16));
}
