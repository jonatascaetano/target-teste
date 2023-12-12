import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_target/presentation/pages/cubit_pages/data_capture_screen.dart';
import 'package:teste_tecnico_target/presentation/pages/cubit_pages/registration_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../injection/dependency_injection.dart';
import '../../blocs/auth_cubit.dart';
import '../../blocs/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: const LoginScreenContent(),
    );
  }
}

class LoginScreenContent extends StatefulWidget {
  const LoginScreenContent({Key? key}) : super(key: key);

  @override
  State<LoginScreenContent> createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<LoginScreenContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Colors.greenAccent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthAuthenticatedState) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const DataCaptureScreen()),
                    (route) => false,
                  );
                }

                if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const Text(
                      'Usuário',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextFormField(
                      controller: _userController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Usuário inválido';
                        }
                        if (value.length > 20) {
                          return 'Usuário não pode ter mais de 20 caracteres';
                        }
                        if (value.endsWith(' ')) {
                          return 'Usuário não pode terminar com espaço';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Senha',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Senha inválida';
                        }
                        if (value.length < 2) {
                          return 'Senha deve ter pelo menos dois caracteres';
                        }
                        if (value.length > 20) {
                          return 'Senha não pode ter mais de 20 caracteres';
                        }
                        if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                          return 'Senha não pode conter caracteres especiais';
                        }
                        if (value.endsWith(' ')) {
                          return 'Senha não pode terminar com espaço';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: _getTextFormFieldHeight(),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            _validateAndLogin(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            minimumSize: Size(
                                double.infinity, _getTextFormFieldHeight()),
                          ),
                          child: const Text(
                            'Entrar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: _getTextFormFieldHeight(),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () =>
                              _navigateToRegistrationPage(context: context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: Size(
                                double.infinity, _getTextFormFieldHeight()),
                          ),
                          child: const Text(
                            'Não tem conta? Cadastre-se',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: GestureDetector(
                        onTap: _openPrivacyPolicy,
                        child: const Text(
                          'Política de Privacidade',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  double _getTextFormFieldHeight() {
    return 56.0;
  }

  void _validateAndLogin(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      UserEntity user = UserEntity(
        username: _userController.text,
        password: _passwordController.text,
      );

      context.read<AuthCubit>().login(user.username, user.password);
    }
  }
}

Future<void> _openPrivacyPolicy() async {
  final Uri url = Uri.parse('https://www.google.com.br');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

void _navigateToRegistrationPage({required BuildContext context}) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const RegistrationScreen()));
}
