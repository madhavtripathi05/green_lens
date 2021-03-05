import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    primaryColor: Colors.green);

final darkTheme = ThemeData(
    primaryColor: Colors.green,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.montserrat().fontFamily);
