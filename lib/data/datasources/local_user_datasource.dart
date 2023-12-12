import 'package:dartz/dartz.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import '../../domain/entities/user_entity.dart';

abstract class LocalUserDataSource {
  Future<Either<Failure, bool>> createAccount(UserEntity user);
  Future<Either<Failure, UserEntity?>> getSavedUser(String username);
  Future<Either<Failure, Unit>> clearUserData(String username);
}
