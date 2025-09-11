import 'package:flutter/material.dart';
import 'package:my_anime_hero_list/layers/presentation/widgets/appBar/appBar_button.dart';

class CustomHomeAppBar extends StatelessWidget {
  final bool isFloating; // Stack ichida ishlatayotganda true bo‘ladi

  const CustomHomeAppBar({super.key, this.isFloating = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E3440),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top, // status bar uchun joy
        left: 8,
        right: 8,
        bottom: 8,
      ),
      child: AppbarButton());
  }
}
