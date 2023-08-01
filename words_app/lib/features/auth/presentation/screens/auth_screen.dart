import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/mixins/keyboard_manager.dart';
import 'package:words_app/core/validators/email_validator.dart';
import 'package:words_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:words_app/features/auth/presentation/bloc/auth_cubit_state.dart';
import 'package:words_app/features/home/presentation/home_screen.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with KeyboardManager {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: BlocConsumer<AuthCubit, AuthCubitState>(
          listener: (context, state) {
            if (state.status == AuthCubitStateStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error ?? "Erro desconhecido"),
                ),
              );
            }
            if (state.status == AuthCubitStateStatus.authenticated) {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            }
          },
          builder: (context, state) {
            if (state.status == AuthCubitStateStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: MediaQuery.of(context).size.height * 0.7,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (!EmailValidator.validateEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().signIn(
                                  emailController.text,
                                  passwordController.text,
                                );
                          }
                        },
                        child: const Text('Sign in'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
