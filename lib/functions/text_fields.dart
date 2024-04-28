import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textFieldFunction({
  required TextEditingController textController,
  required String hintText,
  bool showError = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 22),
    child: TextField(
      controller: textController,
      cursorColor: Colors.black,
      style: GoogleFonts.quicksand(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.quicksand(
          fontSize: 18,
          color: Colors.grey,
        ),
        errorText: showError ? 'Field cannot be empty' : null,
        errorStyle: const TextStyle(color: Colors.red), // Customize error text color
      ),
    ),
  );
}



Widget textFieldBorder({
  required TextEditingController textController,
  required String hintText,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 22),
    child: TextField(
      controller: textController,
      cursorColor: Colors.black,
      style: GoogleFonts.quicksand(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(15)
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.quicksand(
          fontSize: 18,
          color: Colors.grey,
        ),
      ),
    ),
  );
}
