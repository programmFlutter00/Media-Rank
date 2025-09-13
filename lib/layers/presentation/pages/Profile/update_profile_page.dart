import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_rank/layers/application/auth/cubit/auth_cubit.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = context.read<AuthCubit>().state.user;
    if (user != null) {
      _nameController.text = user.userName;
      _photoController.text = user.photoUrl ?? "";
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile")),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("✅ Profile updated successfully!")),
            );
          } else if (state.status == AuthStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? "Update failed")),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == AuthStatus.loading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Avatar preview
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: _photoController.text.isNotEmpty
                        ? NetworkImage(_photoController.text)
                        : (state.user?.photoUrl != null &&
                                state.user!.photoUrl!.isNotEmpty)
                            ? NetworkImage(state.user!.photoUrl!)
                            : null,
                    child: (state.user?.photoUrl == null ||
                            state.user!.photoUrl!.isEmpty)
                        ? const Icon(Icons.person, size: 48)
                        : null,
                  ),
                  const SizedBox(height: 24),

                  // Name input
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Display Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter display name" : null,
                  ),
                  const SizedBox(height: 16),

                  // Photo URL input
                  TextFormField(
                    controller: _photoController,
                    decoration: const InputDecoration(
                      labelText: "Photo URL",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => setState(() {}), // live preview update
                  ),
                  const SizedBox(height: 24),

                  // Update button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().updateProfile(
                                      displayName: _nameController.text.trim(),
                                      photoURL: _photoController.text.trim().isEmpty
                                          ? null
                                          : _photoController.text.trim(),
                                    );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text("Update Profile"),
                    ),
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
