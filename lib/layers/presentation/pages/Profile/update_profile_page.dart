import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_anime_hero_list/layers/application/auth/cubit/auth_cubit.dart';
import 'package:my_anime_hero_list/layers/application/auth/cubit/auth_state.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _photoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile")),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile updated successfully!")),
            );
          } else if (state.status == AuthStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? "Update failed")),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Display Name",
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter display name" : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _photoController,
                    decoration: const InputDecoration(
                      labelText: "Photo URL",
                    ),
                  ),
                  const SizedBox(height: 24),
                  state.status == AuthStatus.loading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().updateProfile(
                                    displayName: _nameController.text.trim(),
                                    photoURL: _photoController.text.trim().isEmpty
                                        ? null
                                        : _photoController.text.trim(),
                                  );
                            }
                          },
                          child: const Text("Update Profile"),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
