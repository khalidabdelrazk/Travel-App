import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget body;
  final Color? color;
  final Color? backgroundColor;
  final int? borderRadius;
  final void Function()? onPressed;

  const CustomButton({
    super.key,
    required this.body,
    this.onPressed,
    this.color,
    this.backgroundColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ?? Theme.of(context).primaryColorDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side:
                borderRadius?.toDouble() != null
                    ? BorderSide(
                      width: borderRadius?.toDouble() ?? 0,
                      color: Theme.of(context).primaryColor,
                    )
                    : BorderSide.none,
          ),
        ),
        onPressed: onPressed,
        child: body,
      ),
    );
  }
}
