import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_anime_hero_list/core/di/di.dart';
import 'package:my_anime_hero_list/layers/application/anime/cubit/anime_cubit.dart';
import 'package:my_anime_hero_list/layers/application/character/cubit/character_cubit.dart';
import 'package:my_anime_hero_list/layers/domain/entities/anime_entity.dart';
import 'package:my_anime_hero_list/layers/domain/entities/character_entity.dart';
import 'package:my_anime_hero_list/layers/presentation/pages/details/anime_detail_page.dart';
import 'package:my_anime_hero_list/layers/presentation/pages/details/character_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Anime Explorer")),
      body: const HomeTab(),
    );
  }
}

/// Asosiy Home Tab
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //  SizedBox(height: 390, child: NewsCharacters()),
        // SectionTitle(title: "Popular Characters"),
        // SizedBox(height: 300, child: PopularCharacters()),
        // SectionTitle(title: "Current Year Anime"),
        // SizedBox(height: 250, child: CurrentCharacters()),
        // SectionTitle(title: "Average Rating"),
        // SizedBox(child: AverageCharacters()),
        Container(
          height: 390,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(color: Colors.white10),
          child: NewsCharacters(),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white10,
            // borderRadius: BorderRadius.circular(16),
          ),
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              SectionTitle(title: "Current Year Anime"),
              SizedBox(height: 8),
              Expanded(child: CurrentCharacters()),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white10,
            // borderRadius: BorderRadius.circular(16),
          ),
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              SectionTitle(title: "Popular Characters"),
              SizedBox(height: 8),
              Expanded(child: PopularCharacters()),
            ],
          ),
        ),

        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white10,
            // borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              SectionTitle(title: "Average Rating"),
              SizedBox(height: 8),
              AverageCharacters(),
            ],
          ),
        ),
      ],
    );
  }
}

//
/// 🔹 1) News (butun ekran eni card + horizontal scroll)
//
class NewsCharacters extends StatefulWidget {
  const NewsCharacters({super.key});

  @override
  _NewsCharactersState createState() => _NewsCharactersState();
}

class _NewsCharactersState extends State<NewsCharacters> {
  final PageController _pageController = PageController(viewportFraction: 1.0);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll(int itemCount) {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % itemCount;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AnimeCubit>()..getUpcoming(type: 'upcoming', page: 1),
      child: BlocBuilder<AnimeCubit, AnimeState>(
        builder: (context, state) {
          if (state.status == AnimeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.animeList.isNotEmpty) {
            final anime = state.animeList;
            // Auto scroll faqat data bo‘lsa ishga tushadi
            if (_timer == null) {
              _startAutoScroll(anime.length);
            }
            return SizedBox(
              // height: 530, // card balandligi
              child: PageView.builder(
                controller: _pageController,
                itemCount: anime.length,
                itemBuilder: (_, i) => BigCharacterCard(anime: anime[i]),
              ),
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}

//
/// 🔹 2) Popular (kichik cardlar, horizontal scroll)
//
class PopularCharacters extends StatelessWidget {
  const PopularCharacters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CharacterCubit>()..getCharacters("popular", page: 1),
      child: BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
          if (state.status == CharacterStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.characters.isNotEmpty) {
            final characters = state.characters;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: characters.length,
              itemBuilder: (_, i) =>
                  CharacterCard(character: characters[i], type: 'pop'),
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}

//
/// 🔹 3) Current (xuddi Popular bilan bir xil)
//
class CurrentCharacters extends StatelessWidget {
  const CurrentCharacters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AnimeCubit>()..getUpcoming(type: 'now', page: 1),
      child: BlocBuilder<AnimeCubit, AnimeState>(
        builder: (context, state) {
          if (state.status == AnimeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.animeList.isNotEmpty) {
            final anime = state.animeList;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: anime.length,
              itemBuilder: (_, i) => CurrentCard(anime: anime[i]),
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}

//
/// 🔹 4) Average (Grid, 2 ta ustun, vertical scroll)
//
class AverageCharacters extends StatelessWidget {
  const AverageCharacters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CharacterCubit>()..getCharacters("average", page: 3),
      child: BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
          if (state.status == CharacterStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.characters.isNotEmpty) {
            final characters = state.characters;
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              physics: const NeverScrollableScrollPhysics(), // 👈 scroll yo'q
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.63,
              ),
              itemCount: characters.length,
              itemBuilder: (_, i) =>
                  CharacterCard(character: characters[i], type: 'ave'),
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}

class BigCharacterCard extends StatelessWidget {
  final AnimeEntity anime;
  const BigCharacterCard({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AnimeDetailPage(anime: anime),
          ),
        );
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rasm
            SizedBox(
              width: double.infinity,
              height: 270,
              child: CachedNetworkImage(
                imageUrl: anime.imageUrl.isNotEmpty ? anime.imageUrl : '',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image, size: 60),
                ),
                filterQuality: FilterQuality.high,
              ),
            ),

            // INFO
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.title.isNotEmpty ? anime.title : "No title",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "${anime.type ?? "N/A"}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "${anime.episodes ?? "?"} ep, ${anime.year > 0 ? anime.year : "N/A"}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      // Rating
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            anime.score?.toStringAsFixed(1) ?? "N/A",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Favorites
                      Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            anime.favorites.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Members
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            anime.members?.toString() ?? "0",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentCard extends StatelessWidget {
  final AnimeEntity anime;
  const CurrentCard({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return InkWell(
       onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AnimeDetailPage(anime: anime)));
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        height: 250,
        // width: double.infinity, // <-- eni to‘liq bo‘ldi
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: anime.imageUrl.isNotEmpty
                ? NetworkImage(anime.imageUrl)
                : const AssetImage("assets/images/placeholder.png")
                      as ImageProvider, // fallback image
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {
              debugPrint("Image load error: $exception");
            },
          ),
        ),
      
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                anime.title.isNotEmpty ? anime.title : "No title",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
      
              Row(
                children: [
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        anime.score?.toStringAsFixed(1) ?? "N/A",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Favorites
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        anime.favorites.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Members
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.grey, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        anime.members?.toString() ?? "0",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;
  final String type;
  const CharacterCard({super.key, required this.character, required this.type});

  @override
  Widget build(BuildContext context) {
    return InkWell(
       onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CharacterDetailPage(character: character)));
      },
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(8),
        child: SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                // borderRadius:
                //     const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  character.images?.jpg?.imageUrl ?? "",
                  height: type == 'pop' ? 170 : 230,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 120,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image, size: 40),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
      
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(character.favorites?.toString() ?? "N/A"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
