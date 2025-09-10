import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_anime_hero_list/core/di/di.dart';
import 'package:my_anime_hero_list/layers/application/anime/anime_current_year/cubit/anime_current_year_cubit.dart';
import 'package:my_anime_hero_list/layers/application/anime/anime_upcoming/cubit/anime_upcoming_cubit.dart';
import 'package:my_anime_hero_list/layers/application/character/character_popular/cubit/character_cubit.dart';
import 'package:my_anime_hero_list/layers/application/theme_cubit.dart';
import 'package:my_anime_hero_list/layers/presentation/pages/main_page.dart';
import 'package:my_anime_hero_list/layers/presentation/pages/screens/home_page.dart';
import 'package:my_anime_hero_list/layers/presentation/pages/style/theme.dart';
// import 'package:my_anime_hero_list/layers/presentation/pages/theme_cubit.dart';

void main() async {
  await setupSingletons();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider(
          create: (_) => sl<AnimeUpcomingCubit>()..getUpcoming(page: 1,),
        ),
        BlocProvider(
          create: (_) => sl<AnimeCurrentYearCubit>()..getCurrentYearAnime(page: 1,),
        ),
        BlocProvider(
          create: (_) => sl<CharacterCubit>()..getCharacters(page: 1),
        ),
        
        BlocProvider(
          create: (_) => ThemeCubit(), // Theme uchun Cubit
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            home: const MainPage(),
          );
        },
      ),
    );
  }
}
