import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final VoidCallback? onTap;
  final TextEditingController? controller;

  const SearchInput({super.key, this.onTap, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Search MAHL",
        hintStyle: const TextStyle(color: Colors.black),
        prefixIcon: const Icon(Icons.search, color: Colors.black),
        prefixIconConstraints: const BoxConstraints(
          minHeight: 50,
          minWidth: 50,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 16),
    );
  }
}
