import 'package:flutter/material.dart';
import 'package:media_rank/layers/presentation/pages/Search/search_page.dart';

class AppbarButton extends StatelessWidget {
  const AppbarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchPage()),
              );
            },
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.black),
                  SizedBox(width: 10),
                  Text(
                    "Search MAHL",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),

        // 🔹 Profile icon -> endDrawer ochiladi
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.menu_sharp, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openEndDrawer(); // 🔥 Drawer ochiladi
            },
          ),
        ),
      ],
    );
  }
}
