import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  final String mainText;
  final Function()? onpressed;
  const CustomCard({super.key, required this.mainText, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 0, 0, 0),
            boxShadow: [
              BoxShadow(
                offset: Offset(5, 5),
                blurRadius: 6.2,
                color: Color.fromARGB(117, 0, 0, 0),
              ),
              BoxShadow(
                offset: Offset(-5, -5),
                blurRadius: 6.2,
                color: Color.fromARGB(117, 0, 0, 0),
              ),
            ]),
        child: Text(
          mainText,
          style: GoogleFonts.comicNeue(
              color: Colors.white, fontWeight: FontWeight.w500),
        ),
        height: 150,
        width: 150,
      ),
    );
  }
}
