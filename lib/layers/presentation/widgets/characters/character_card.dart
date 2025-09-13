
import 'package:flutter/material.dart';
import 'package:media_rank/layers/domain/entities/character_entity.dart';
import 'package:media_rank/layers/presentation/pages/Details/character_detail_page.dart';


class CharacterCard extends StatelessWidget {
  final CharacterEntity character;
  final String type;
  const CharacterCard({super.key, required this.character, required this.type});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CharacterDetailPage(character: character),
          ),
        );
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
