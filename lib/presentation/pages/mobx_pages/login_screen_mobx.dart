import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teste_tecnico_target/presentation/blocs/auth_state.dart';
import 'package:teste_tecnico_target/presentation/route/route_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/injection/dependency_injection.dart';
import '../../stores/auth_store.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authStore = getIt<AuthStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: Observer(
        builder: (context) {
          switch (authStore.state.runtimeType) {
            case AuthAuthenticatedState:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                RouteManager.navigateToAndRemoveUntil(
                    RouteName.dataCaptureScreenMobx);
              });

              return Container();
            case AuthErrorState:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final errorMessage =
                    (authStore.state as AuthErrorState).errorMessage;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              });
              break;
            default:
              break;
          }

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.blueAccent],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildMainContent(context, authStore),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, AuthStore authStore) {
    return Form(
      key: authStore.formKey,
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
                onPressed: () {
                  _validateAndLogin(context, authStore);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  minimumSize: Size(double.infinity, _getTextFormFieldHeight()),
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
              height: 56.0,
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: () => _navigateToRegistrationPage(context: context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  minimumSize: Size(double.infinity, _getTextFormFieldHeight()),
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
      ),
    );
  }

  double _getTextFormFieldHeight() {
    return 56.0;
  }

  void _validateAndLogin(BuildContext context, AuthStore authStore) async {
    if (authStore.formKey.currentState?.validate() ?? false) {
      await authStore.login();
    }
  }

  Future<void> _openPrivacyPolicy() async {
    final Uri url = Uri.parse('https://www.google.com.br');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void _navigateToRegistrationPage({required BuildContext context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RouteManager.navigateTo(RouteName.registerMobx);
    });
  }
}
