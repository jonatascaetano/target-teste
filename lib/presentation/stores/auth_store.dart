import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/auth_usecase.dart';
import '../ViewModels/user_viewmodel.dart.dart';
import '../blocs/auth_state.dart';

part 'auth_store.g.dart';

// ignore: library_private_types_in_public_api
class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final AuthUseCase _authUseCase;
  final UserViewModel _userViewModel;

  _AuthStoreBase(this._authUseCase, this._userViewModel);

  @observable
  AuthState state = AuthInitialState();

  @observable
  TextEditingController userController = TextEditingController();

  @observable
  TextEditingController passwordController = TextEditingController();

  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  Future<void> login() async {
    var result =
        await _authUseCase.login(userController.text, passwordController.text);
    result.fold((l) {
      state = const AuthErrorState("Usuário ou senha inválidos");
    }, (r) {
      bool isAuthenticated = r;
      if (isAuthenticated) {
        _userViewModel.setLoggedInUser(UserEntity(
            username: userController.text, password: passwordController.text));
        state = AuthAuthenticatedState();
      } else {
        state = const AuthErrorState("Usuário ou senha inválidos");
      }
    });
  }

  @action
  Future<void> createAccount() async {
    var result = await _authUseCase.createAccount(UserEntity(
        username: userController.text, password: passwordController.text));
    result.fold((l) {
      state = AuthErrorState(l.message);
    }, (r) {
      bool accountCreated = r;

      if (accountCreated) {
        _userViewModel.setLoggedInUser(UserEntity(
            username: userController.text, password: passwordController.text));
        state = AuthAuthenticatedState();
      } else {
        state = const AuthErrorState(
            "Usuário já existe. Escolha outro nome de usuário.");
      }
    });
  }

  @action
  void logout() {
    _authUseCase.logout(_userViewModel.loggedInUser!.username);
    _userViewModel.clearLoggedInUser();
  }
}
