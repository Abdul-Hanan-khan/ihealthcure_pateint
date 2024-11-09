import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>showSnackbar(
    BuildContext context, String content,
    {Color color = const Color(0xff252525)}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1000),
      backgroundColor: color,
      content: Text(
        content,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white),
      )));
}
