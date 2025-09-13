
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_rank/core/di/di.dart';
import 'package:media_rank/layers/application/character/character_popular/cubit/character_cubit.dart';
import 'package:media_rank/layers/presentation/widgets/characters/character_card.dart';


class PopularCharacters extends StatelessWidget {
  const PopularCharacters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CharacterCubit>()..getPopularCharacters(page: 1),
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
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.characters.length,
                itemBuilder: (_, i) =>
                    CharacterCard(character: state.characters[i], type: 'pop'),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
