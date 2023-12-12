import 'package:dartz/dartz.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/domain/entities/user_entity.dart';
import 'package:teste_tecnico_target/domain/repositories/account_repository.dart';

class AuthUseCase {
  final AccountRepository _accountRepository;

  AuthUseCase(this._accountRepository);

  Future<Either<Failure, bool>> login(String username, String password) async {
    try {
      final result = await _accountRepository.getSavedUser(username);

      return result.fold(
        (failure) => Left(failure),
        (user) {
          bool isLogged = user != null && user.password == password;
          return isLogged ? const Right(true) : Left(Failure('error'));
        },
      );
    } catch (e) {
      return Left(Failure('error'));
    }
  }

  Future<Either<Failure, bool>> createAccount(UserEntity user) async {
    return await _accountRepository.createAccount(user);
  }

  Future<Either<Failure, Unit>> logout(String username) async {
    return await _accountRepository.logout(username);
  }
}
