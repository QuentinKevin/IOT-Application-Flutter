import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final double labelSize;

  const TextWidget({super.key, required this.label, required this.labelSize});
  
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontSize: labelSize),
      );
  }
}