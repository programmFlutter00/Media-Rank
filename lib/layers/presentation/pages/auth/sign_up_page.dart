import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_rank/layers/application/auth/cubit/auth_cubit.dart';
import 'package:media_rank/layers/domain/entities/auth/sign_up.dart';
import 'package:media_rank/layers/presentation/pages/home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
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
    _usernameController.dispose();
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
              const SnackBar(content: Text("✅ Registration successful")),
            );
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false); // qaytib Sign In ga
          } else if (state.status == AuthStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? "SignUp failed")),
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
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Username
                      TextFormField(
                        controller: _usernameController,
                        decoration: _inputDecoration("Username"),
                        validator: (value) =>
                            value!.isEmpty ? "Ismni kiriting" : null,
                      ),
                      const SizedBox(height: 16),

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
                                  context.read<AuthCubit>().signUp(
                                        SignUp(
                                          _usernameController.text.trim(),
                                          _emailController.text.trim(),
                                          _passwordController.text.trim(),
                                        ),
                                      );
                                }
                              },
                              child: const Text("Sign Up"),
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
