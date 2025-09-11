
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_anime_hero_list/core/di/di.dart';
import 'package:my_anime_hero_list/layers/application/character/character_popular/cubit/character_cubit.dart';
import 'package:my_anime_hero_list/layers/presentation/widgets/characters/character_card.dart';



class AvarageCharacters extends StatelessWidget {
  const AvarageCharacters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CharacterCubit>()..getCharacters(page: 3),
      child: BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
          switch (state.status) {
            case CharacterStatus.loading:
              return const Center(child: CircularProgressIndicator());

            case CharacterStatus.failed:
              return Center(
                child: Text(
                  state.error ?? "Something went wrong",
                  style: const TextStyle(color: Colors.red),
                ),
              );

            case CharacterStatus.success:
              if (state.characters.isEmpty) {
                return const Center(child: Text("No characters found"));
              }
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                physics: const NeverScrollableScrollPhysics(), // 👈 scroll yo‘q
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.63,
                ),
                itemCount: state.characters.length,
                itemBuilder: (_, i) =>
                    CharacterCard(character: state.characters[i], type: 'ave'),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}