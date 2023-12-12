import 'package:dartz/dartz.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/data/datasources/local_user_datasource.dart';
import 'package:teste_tecnico_target/domain/entities/user_entity.dart';
import 'package:teste_tecnico_target/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final LocalUserDataSource _localDataSource;

  AccountRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, bool>> createAccount(UserEntity user) async {
    return await _localDataSource.createAccount(user);
  }

  @override
  Future<Either<Failure, UserEntity?>> getSavedUser(String username) async {
    return await _localDataSource.getSavedUser(username);
  }

  @override
  Future<Either<Failure, Unit>> logout(String username) async {
    return await Future.delayed(const Duration(seconds: 3))
        .then((value) => const Right(unit));
  }
}
