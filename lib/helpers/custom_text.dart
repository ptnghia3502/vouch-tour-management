import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;

  // name constructor that has a positional parameters with the text required
  // and the other parameters optional
  CustomText({
    required this.text,
    required this.size,
    required this.color,
    required this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,style: TextStyle(fontSize: size ?? 16, color: color ?? Colors.black, fontWeight: weight ?? FontWeight.normal),
    );
  }
}