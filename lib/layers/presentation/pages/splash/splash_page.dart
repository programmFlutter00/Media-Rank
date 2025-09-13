import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_rank/layers/application/auth/cubit/auth_cubit.dart';
import 'package:media_rank/layers/presentation/pages/auth/sign_in_page.dart';
import 'package:media_rank/layers/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Fade animatsiya
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  void _navigateNext(AuthStatus status) {
    if (!mounted) return;

    if (status == AuthStatus.authenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else if (status == AuthStatus.unauthenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const SignInPage()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status != AuthStatus.initial &&
            state.status != AuthStatus.loading) {
          _navigateNext(state.status);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF2E3440),
        body: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🔹 App logosi
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
                const SizedBox(height: 32),
                // 🔹 App nomi
                const Text(
                  "Media Rank",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                // 🔹 Progress bar
                const CircularProgressIndicator(color: Colors.white70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
