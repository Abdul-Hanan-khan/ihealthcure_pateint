import 'package:flutter/material.dart';

class Health {
  Color? gradientColor;
  String? title;
  String? firsttitle;
  Widget? widget;
  String? secondtitle;
 
  Color? color;
  Function()? onPressed;
  Health(
      {this.title,
  
      this.color,
      this.onPressed,
      this.gradientColor,
      this.firsttitle,
      this.widget,
      this.secondtitle
      });
}
