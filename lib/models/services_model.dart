import 'package:flutter/material.dart';

class Services {
  Color? gradientColor;
  String? title;
  String? imagePath;
  Color? color;
  Function()? onPressed;
  Services(
      {this.title,
      this.imagePath,
      this.color,
      this.onPressed,
      this.gradientColor});
}
