import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:media_rank/layers/presentation/pages/admin/admin_page.dart';
import 'package:media_rank/layers/presentation/pages/profile/profile_page.dart';
import 'package:media_rank/layers/presentation/widgets/appBar/appBar_button.dart';
import 'package:media_rank/layers/presentation/widgets/appBar/custom_home_appBer.dart';
import 'package:media_rank/layers/presentation/widgets/characters/avarage_characters.dart';
import 'package:media_rank/layers/presentation/widgets/characters/popular_characters.dart';
import 'package:media_rank/layers/presentation/widgets/current_year/current_year_anime.dart';
import 'package:media_rank/layers/presentation/widgets/news/news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = false;
  final double _inputSectionHeight = 410;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > _inputSectionHeight && !_showAppBar) {
        setState(() => _showAppBar = true);
      } else if (_scrollController.offset <= _inputSectionHeight &&
          _showAppBar) {
        setState(() => _showAppBar = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      endDrawer: Drawer(
        shape: LinearBorder.none,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // 🔹 Drawer yopiladi
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const ProfilePage(), // 🔹 ProfilePage sahifasi
                  ),
                );
              },
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Color(0xFF2E3440)),
                accountName: Text(
                  user?.displayName ?? "No Name",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  user?.email ?? "No Email",
                  style: const TextStyle(color: Colors.white70),
                ),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Color(0xFF2E3440)),
                ),
              ),
            ),
             ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminPage())),
              leading: Icon(Icons.home, color: Colors.white),
              title: Text("Admin"),
            ),
            const ListTile(
              leading: Icon(Icons.favorite, color: Colors.red),
              title: Text("Favorites"),
            ),
            const ListTile(
              leading: Icon(Icons.settings, color: Colors.grey),
              title: Text("Settings"),
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              // News Carousel
              Container(
                height: 390,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(color: Colors.white10),
                child: const News(),
              ),
              const SizedBox(height: 5),

              // Search + Profile button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AppbarButton(),
              ),
              const SizedBox(height: 5),

              // Current Year Anime
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(color: Colors.white10),
                height: 350,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SectionTitle(title: "Current Year Anime"),
                    SizedBox(height: 8),
                    Expanded(child: CurrentYearAnime()),
                  ],
                ),
              ),

              // Popular Characters
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 6,
                ),
                decoration: BoxDecoration(color: Colors.white10),
                height: 350,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SectionTitle(title: "Popular Characters"),
                    SizedBox(height: 8),
                    Expanded(child: PopularCharacters()),
                  ],
                ),
              ),

              // Average Characters
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(color: Colors.white10),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SectionTitle(title: "Characters"),
                    SizedBox(height: 8),
                    AvarageCharacters(),
                  ],
                ),
              ),
            ],
          ),

          // Custom AppBar
          if (_showAppBar)
            Positioned(top: 0, left: 0, right: 0, child: CustomHomeAppBar()),
        ],
      ),
    );
  }
}

//
/// Section sarlavhasi
//
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
