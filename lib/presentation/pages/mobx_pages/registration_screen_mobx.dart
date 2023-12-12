import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teste_tecnico_target/presentation/blocs/auth_state.dart';
import 'package:teste_tecnico_target/presentation/route/route_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/injection/dependency_injection.dart';
import '../../stores/auth_store.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        backgroundColor: Colors.blue,
      ),
      body: Observer(
        builder: (context) {
          AuthStore authStore = getIt<AuthStore>();

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.blueAccent],
              ),
            ),
            child: Form(
              key: authStore.formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const Text(
                      'Usuário',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextFormField(
                      controller: authStore.userController,
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
                        if (value.length < 2) {
                          return 'Usuário deve ter pelo menos dois caracteres';
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
                      controller: authStore.passwordController,
                      obscureText: true,
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
                        height: 56.0,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () async {
                            await _validateAndRegister(context, authStore);

                            if (authStore.state is AuthAuthenticatedState) {
                              RouteManager.navigateToAndRemoveUntil(
                                  RouteName.dataCaptureScreenMobx);
                            } else if (authStore.state is AuthErrorState) {
                              final e = authStore.state as AuthErrorState;
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.errorMessage),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            minimumSize: Size(
                                double.infinity, _getTextFormFieldHeight()),
                          ),
                          child: const Text(
                            'Cadastrar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  double _getTextFormFieldHeight() {
    return 56.0;
  }

  Future<void> _openPrivacyPolicy() async {
    final Uri url = Uri.parse('https://www.google.com.br');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _validateAndRegister(
      BuildContext context, AuthStore authStore) async {
    if (authStore.formKey.currentState?.validate() ?? false) {
      await authStore.createAccount();
    }
  }
}
