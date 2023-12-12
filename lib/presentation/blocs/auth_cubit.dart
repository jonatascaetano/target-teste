import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_target/domain/entities/user_entity.dart';
import 'package:teste_tecnico_target/domain/usecases/auth_usecase.dart';
import 'package:teste_tecnico_target/presentation/ViewModels/user_viewmodel.dart.dart';
import 'package:teste_tecnico_target/presentation/blocs/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase _authUseCase;
  final UserViewModel _userViewModel;

  AuthCubit(
    this._authUseCase,
    this._userViewModel,
  ) : super(AuthInitialState());

  Future<void> login(String username, String password) async {
    var resultl = await _authUseCase.login(username, password);
    resultl.fold((l) {
      emit(const AuthErrorState("Usuário ou senha inválidos"));
    }, (r) {
      bool isAuthenticated = r;
      if (isAuthenticated) {
        _userViewModel.setLoggedInUser(
            UserEntity(username: username, password: password));
        emit(AuthAuthenticatedState());
      } else {
        emit(const AuthErrorState("Usuário ou senha inválidos"));
      }
    });
  }

  Future<void> createAccount(UserEntity user) async {
    var result = await _authUseCase.createAccount(user);
    result.fold((l) {
      emit(const AuthErrorState(
          "Usuário já existe. Escolha outro nome de usuário."));
    }, (r) {
      bool accountCreated = r;
      if (accountCreated) {
        _userViewModel.setLoggedInUser(
            UserEntity(username: user.username, password: user.password));
        emit(AuthAuthenticatedState());
      } else {
        emit(const AuthErrorState(
            "Usuário já existe. Escolha outro nome de usuário."));
      }
    });
  }

  void logout() async {
    _authUseCase.logout(_userViewModel.loggedInUser!.username);
    _userViewModel.clearLoggedInUser();
  }
}
