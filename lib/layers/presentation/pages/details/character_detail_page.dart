import 'package:flutter/material.dart';
import 'package:media_rank/layers/domain/entities/character_entity.dart';

class CharacterDetailPage extends StatelessWidget {
  final CharacterEntity character;
  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('MR'),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                        character.images?.jpg?.imageUrl ??
                            "https://via.placeholder.com/200x280",
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
                          "Favorites",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          "${character.favorites ?? 0}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),

                      

                        const Text(
                          "Nicknames",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          (character.nicknames?.isNotEmpty ?? false)
                              ? character.nicknames!.join(", ")
                              : "None",textAlign: TextAlign.end,
                          style: const TextStyle(
                            
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 Name (title style)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      character.name,
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (character.nameKanji != null)
                      Text(
                        character.nameKanji!,
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 About section
            if (character.about != null && character.about!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("About", style: textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      character.about!,
                      style: textTheme.bodyMedium,
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
