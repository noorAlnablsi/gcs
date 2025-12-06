// lib/core/widgets/app_dropdown.dart

import 'package:flutter/material.dart';
import 'package:flutter_internet_application/core/resource/color.dart';


class AppDropdown extends StatelessWidget {
  const AppDropdown({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText = '',
    this.width = 330,
    this.height = 60,
  }) : super(key: key);

  final List<String> items;
  final String? value;
  final void Function(String?) onChanged;
  final String hintText;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: Text(hintText, textAlign: TextAlign.right),
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
