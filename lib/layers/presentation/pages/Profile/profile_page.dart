import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_anime_hero_list/layers/application/theme_cubit.dart';
import 'package:my_anime_hero_list/layers/presentation/pages/Profile/update_profile_page.dart';
import 'package:my_anime_hero_list/layers/presentation/pages/splash/splash_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [IconButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateProfilePage())), icon: Icon(Icons.edit))],
      ),
      body: user == null
          ? const Center(child: Text("No user signed in"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : const AssetImage("assets/images/default_avatar.png")
                            as ImageProvider,
                  ),
                  const SizedBox(height: 20),

                  // Username
                  Text(
                    user.displayName ?? "No username",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Email
                  Text(
                    user.email ?? "No email",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Cardlar
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: ListTile(
                      leading: const Icon(Icons.dark_mode),
                      title: const Text("Toggle Dark/Light Mode"),
                      trailing: Switch(
                        value: themeCubit.state == ThemeMode.dark,
                        onChanged: (_) => themeCubit.toggleTheme(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text("Sign Out"),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SplashPage()), (route) => false);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
