import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final String txt;
  final Color? color;
  final void Function()? onPressed;
  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.txt,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        overlayColor: Colors.transparent,
      ),
      child: Text(
        txt,
        style: GoogleFonts.roboto(
          color: color ?? Theme.of(context).primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.none,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
