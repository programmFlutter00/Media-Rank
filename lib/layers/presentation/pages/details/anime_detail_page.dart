import 'package:flutter/material.dart';
import 'package:my_anime_hero_list/layers/domain/entities/anime_entity.dart';

class AnimeDetailPage extends StatelessWidget {
  final AnimeEntity anime;
  const AnimeDetailPage({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(anime.title), centerTitle: true),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Poster + Basic Info (Row)
          Padding(
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
            const Text("Score",style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),),
            Text(
              "⭐ ${anime.score?.toStringAsFixed(1) ?? "N/A"}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            const Text("Popularity",style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),),
            Text("${anime.popularity}",style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),),
            const SizedBox(height: 20),

            const Text("Favorite",style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),),
            Text("${anime.favorites}",style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),),
            const SizedBox(height: 20),

            const Text("Members",style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),),
            Text("${anime.members}",style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),),
          ],
        ),
      ),
    ],
  ),
),
 const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      anime.title,
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              color: Colors.white10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${anime.type}, ${anime.year}",style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              )),
                  Text(anime.source,style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              )),
                  Text("${anime.episodes} ep, ${anime.duration}",style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              )),
                ],
              ),
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
                    _buildSection(context, "Demographics", anime.demographics),

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
          ],
        ),
      ),
    );
  }

  // 🔹 Helper for Sections
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
}
