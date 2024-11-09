import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';

class DropdownDataWidget<T> extends StatelessWidget {
  final BoxBorder? boxBorder;
  final Color? fillColor;
  final Color? textColor;
  final String? hint;
  final List<T> items;
  final T? selectedValue;
  final Function()? onTap;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemTextExtractor;

  // ignore: use_key_in_widget_constructors
  const DropdownDataWidget({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.itemTextExtractor,
    this.hint,
    this.fillColor,
    this.textColor,
    this.boxBorder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(right: 5),
      decoration: BoxDecoration(
          color: fillColor ?? ColorManager.kPrimaryLightColor,
          borderRadius: BorderRadius.circular(10),
          border: boxBorder),
      child: DropdownButton<T>(
        hint: Text(
          '$hint',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: ColorManager.kGreyColor),
        ),
        //padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(right: 0),
        underline: const SizedBox.shrink(),
        value: selectedValue,
        isExpanded: true,
        menuMaxHeight: Get.height * 0.8,
        icon: Image.asset(Images.dropdown),
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              itemTextExtractor(
                  item), // Extract display text using the function
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: ColorManager.kGreyColor),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
