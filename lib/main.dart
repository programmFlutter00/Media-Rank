import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_rank/core/di/di.dart';
import 'package:media_rank/firebase_options.dart';
import 'package:media_rank/layers/application/anime/anime_character/cubit/anime_character_cubit.dart';
import 'package:media_rank/layers/application/anime/anime_current_year/cubit/anime_current_year_cubit.dart';
import 'package:media_rank/layers/application/anime/anime_upcoming/cubit/anime_upcoming_cubit.dart';
import 'package:media_rank/layers/application/auth/cubit/auth_cubit.dart';
import 'package:media_rank/layers/application/character/character_popular/cubit/character_cubit.dart';
import 'package:media_rank/layers/application/theme_cubit.dart';
import 'package:media_rank/layers/presentation/pages/splash/splash_page.dart';
import 'package:media_rank/layers/presentation/pages/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupSingletons();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>()),
         BlocProvider(
          create: (_) => sl<AnimeUpcomingCubit>()..getUpcoming(page: 1,),
        ),
        BlocProvider(
          create: (_) => sl<AnimeCurrentYearCubit>()..getCurrentYearAnime(page: 1,),
        ),
        BlocProvider(
          create: (_) => sl<AnimeCharacterCubit>()..getCharacters(6),
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
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
