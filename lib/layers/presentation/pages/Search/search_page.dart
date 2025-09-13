import 'package:flutter/material.dart';
import 'package:media_rank/layers/presentation/widgets/search_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 35,
        title: SearchInput(),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: const Center(
        child: Text("Search Page", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
