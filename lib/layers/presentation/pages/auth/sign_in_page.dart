import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_rank/layers/application/auth/cubit/auth_cubit.dart';
import 'package:media_rank/layers/domain/entities/auth/sign_in.dart';
import 'package:media_rank/layers/presentation/pages/auth/sign_up_page.dart';
import 'package:media_rank/layers/presentation/pages/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E3440),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("✅ Login successful")),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),(route) => false
            );
          } else if (state.status == AuthStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? "Login failed")),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: FadeTransition(
                opacity: _fade,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Email
                      TextFormField(
                        controller: _emailController,
                        decoration: _inputDecoration("Email"),
                        validator: (value) =>
                            value!.isEmpty ? "Emailni kiriting" : null,
                      ),
                      const SizedBox(height: 16),

                      // Password
                      TextFormField(
                        controller: _passwordController,
                        decoration: _inputDecoration("Password"),
                        obscureText: true,
                        validator: (value) =>
                            value!.length < 6 ? "Kamida 6 ta belgi kiriting" : null,
                      ),
                      const SizedBox(height: 24),

                      state.status == AuthStatus.loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor: Colors.white10,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().signIn(
                                        SignIn(
                                          _emailController.text.trim(),
                                          _passwordController.text.trim(),
                                        ),
                                      );
                                }
                              },
                              child: const Text("Sign In"),
                            ),
                      const SizedBox(height: 16),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.white10,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
