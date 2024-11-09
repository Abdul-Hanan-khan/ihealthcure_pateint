// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final bool? isNetworkImage;
  final Function()? onpressed;
  final bool? isSvg;
  final Color? color;
  final Color? backgroundColor;
  final String? imagePath;
  const ImageContainer({
    super.key,
    this.imagePath,
    this.color,
    this.backgroundColor,
    this.isSvg = true,
    this.onpressed,
    this.isNetworkImage,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: backgroundColor),
        child: IconButton(
            onPressed: onpressed,
            icon: isNetworkImage == true &&
                    imagePath !=
                        'https://qa.patient.ihealthcure.com/File/Download/'
                ? Image.network(
                    imagePath!,
                  )
                : isSvg == true
                    ? SvgPicture.asset(
                        imagePath!,
                        color: color,
                      )
                    : Image.asset(
                        imagePath!,
                        color: color,
                      )));
  }
}
