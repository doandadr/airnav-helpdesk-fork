import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? hintText;

  const SearchField({
    super.key,
    required this.onChanged,
    this.hintText,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Container(
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Get.theme.shadowColor.withOpacity(Get.isDarkMode ? 0.3 : 0.08),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          focusNode: _focusNode,
          controller: _controller,
          onChanged: widget.onChanged,
          onTapOutside: (event) {
            _focusNode.unfocus();
          },
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Cari...',
            hintStyle: TextStyle(
              color: Get.theme.hintColor,
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 20,
              color: Get.theme.hintColor,
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close),
                    color: Get.theme.hintColor,
                    onPressed: () {
                      _controller.clear();
                      widget.onChanged('');
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Get.theme.primaryColor,
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
