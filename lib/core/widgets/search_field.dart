import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String? hintText;

  const SearchField({super.key, required this.onChanged, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Material(
        elevation: 2.0,
        shadowColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.transparent,
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText ?? 'Cari...',
            hintStyle: TextStyle(
              color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 20,
              color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[500],
            ),
            filled: true,
            fillColor: Get.theme.cardColor,
            contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
