import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_anime_hero_list/layers/application/theme_cubit.dart';
// import 'package:my_anime_hero_list/layers/presentation/pages/theme_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Profile Page"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                themeCubit.toggleTheme();
              },
              child: const Text("Toggle Dark/Light Mode"),
            ),
          ],
        ),
      ),
    );
  }
}
