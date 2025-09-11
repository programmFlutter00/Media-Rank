import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_anime_hero_list/core/di/di.dart';
import 'package:my_anime_hero_list/layers/application/anime/anime_upcoming/cubit/anime_upcoming_cubit.dart';
import 'package:my_anime_hero_list/layers/presentation/widgets/news/carousel_card.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
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
      create: (_) => sl<AnimeUpcomingCubit>()..getUpcoming(page: 1),
      child: BlocBuilder<AnimeUpcomingCubit, AnimeUpcomingState>(
        builder: (context, state) {
          if (state.status == AnimeUpcomingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.animeList.isNotEmpty) {
            final anime = state.animeList;
            if (_timer == null) {
              _startAutoScroll(anime.length);
            }

            return Stack(
              children: [
                SizedBox(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: anime.length,
                    itemBuilder: (_, i) => CarouselCard(anime: anime[i]),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      // color: Colors.yellow,
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "News",
                      style: TextStyle(
                        // color: Colors.red,
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}
