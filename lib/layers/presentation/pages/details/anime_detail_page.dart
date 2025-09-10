import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_anime_hero_list/core/di/di.dart';
import 'package:my_anime_hero_list/layers/application/anime/anime_character/cubit/anime_character_cubit.dart';
import 'package:my_anime_hero_list/layers/domain/entities/anime_character_entity.dart';
import 'package:my_anime_hero_list/layers/domain/entities/anime_entity.dart';
import 'package:my_anime_hero_list/layers/domain/entities/character_entity.dart';

class AnimeDetailPage extends StatelessWidget {
  final AnimeEntity anime;
  const AnimeDetailPage({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('MAHL'), ),
      body: BlocProvider(
        create: (_) => sl<AnimeCharacterCubit>()..getCharacters(anime.malId),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Poster + Basic Info
              _buildHeader(anime),
              const SizedBox(height: 24),

              // 🔹 Title
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    anime.title,
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // 🔹 Info row
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                color: Colors.white10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${anime.type}, ${anime.year}",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      anime.source,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      "${anime.episodes} ep, ${anime.duration}",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              BlocBuilder<AnimeCharacterCubit, AnimeCharacterState>(
                builder: (context, state) {
                  if (state.status == AnimeCharacterStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == AnimeCharacterStatus.failed) {
                    return Center(
                      child: Text(
                        state.error ?? "Failed to load characters",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state.status == AnimeCharacterStatus.success) {
                    if (state.characters.isEmpty) {
                      return const Center(child: Text("No characters found"));
                    }
                    return _buildCharacterList(state.characters);
                  }
                  return const SizedBox.shrink();
                },
              ),

              // 🔹 Genres, Studios, etc.
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (anime.genres.isNotEmpty)
                      _buildSection(context, "Genres", anime.genres),

                    if (anime.studios.isNotEmpty)
                      _buildSection(context, "Studios", anime.studios),
                    if (anime.producers.isNotEmpty)
                      _buildSection(context, "Producers", anime.producers),
                    if (anime.themes.isNotEmpty)
                      _buildSection(context, "Themes", anime.themes),
                    if (anime.demographics.isNotEmpty)
                      _buildSection(
                        context,
                        "Demographics",
                        anime.demographics,
                      ),

                    const SizedBox(height: 24),

                    // 🔹 Synopsis
                    if (anime.synopsis.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Synopsis", style: textTheme.titleLarge),
                          const SizedBox(height: 8),
                          Text(anime.synopsis, style: textTheme.bodyMedium),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Poster + Score/Popularity
  Widget _buildHeader(AnimeEntity anime) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster
          Container(
            width: 250,
            height: 320,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white70),
            ),
            child: ClipRRect(
              child: Image.network(
                anime.imageUrl.isNotEmpty
                    ? anime.imageUrl
                    : "https://via.placeholder.com/200x280",
                width: 230,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Score",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                Text(
                  "⭐ ${anime.score?.toStringAsFixed(1) ?? "N/A"}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Popularity",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                Text(
                  "${anime.popularity}",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Favorite",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                Text(
                  "${anime.favorites}",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Members",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                Text(
                  "${anime.members}",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Chips Section
  Widget _buildSection(BuildContext context, String title, List<String> items) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: items
                .map(
                  (e) => Chip(
                    label: Text(e),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: theme.chipTheme.backgroundColor,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  // 🔹 Characters List
  Widget _buildCharacterList(List<AnimeCharacterEntity> characters) {
    const double imageSize = 120; // rasmlar bir xil hajmda

    return SizedBox(
      height:
          imageSize * 2 +
          100, // character + voice actor uchun yetarli balandlik
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final c = characters[index];
          final va = c.voiceActors.isNotEmpty ? c.voiceActors.first : null;

          return Container(
            width: imageSize,
            // margin: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                // Character Image with name overlay
                Stack(
                  children: [
                    ClipRRect(
                      // borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        c.character.imageUrl.isNotEmpty
                            ? c.character.imageUrl
                            : "https://via.placeholder.com/120",
                        width: imageSize - 20,
                        height: imageSize + 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                       
                        ),
                        child: Text(
                          c.character.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // Voice Actor Image with name overlay
                if (va != null)
                  Stack(
                    children: [
                      ClipRRect(
                        // borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          va.imageUrl.isNotEmpty
                              ? va.imageUrl
                              : "https://via.placeholder.com/120",
                          width: imageSize - 20,
                          height: imageSize + 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                           
                          ),
                          child: Text(
                            va.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
