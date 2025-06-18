import 'package:flutter/material.dart';

class RoundTextBox extends StatelessWidget {
  const RoundTextBox({
    super.key,
    this.prefixIcon,
    this.hintText,
    this.controller,
  });
  final Widget? prefixIcon;
  final String? hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      // height: 50,
      // width: width,
      // decoration: BoxDecoration(
      //   color: Colors.grey.shade200,
      //     borderRadius: BorderRadius.circular(16),
      //     border: Border.all(color: Theme.of(context).indicatorColor,width: 1)
      // ),
      child: TextField(
        controller: controller,
        style: TextTheme.of(context).bodyMedium,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Theme.of(context).indicatorColor),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
