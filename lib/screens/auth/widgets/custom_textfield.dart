import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labeltext;
  final Widget icon;
  final double size;
  CustomTextField(
      {super.key,
      this.controller,
      required this.labeltext,
      required this.icon,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(fontSize: size),
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Color(0xffE7E7F2),
        label: Text(labeltext),
        labelStyle: GoogleFonts.poppins(fontSize: size, color: Colors.black),
        prefixIcon: icon,
        prefixIconColor: const Color(0xff000221),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
    );
  }
}
