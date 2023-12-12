import 'package:dartz/dartz.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/domain/entities/user_entity.dart';

abstract class AccountRepository {
  Future<Either<Failure, bool>> createAccount(UserEntity user);
  Future<Either<Failure, UserEntity?>> getSavedUser(String username);
  Future<Either<Failure, Unit>> logout(String username);
}
