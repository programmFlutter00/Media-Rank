
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_rank/core/di/di.dart';
import 'package:media_rank/layers/application/anime/anime_current_year/cubit/anime_current_year_cubit.dart';
import 'package:media_rank/layers/presentation/widgets/current_year/current_card.dart';



class CurrentYearAnime extends StatelessWidget {
  const CurrentYearAnime({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // create: (_) => sl<AnimeUpcomingCubit>()..getUpcoming(type: 'now', page: 1),
      create: (_) => sl<AnimeCurrentYearCubit>()..getCurrentYearAnime(page: 1),

      child: BlocBuilder<AnimeCurrentYearCubit, AnimeCurrentYearState>(
        builder: (context, state) {
          if (state.status == AnimeCurrentYearStatus.loading) {
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
