import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/data/datasources/local_user_datasource.dart';
import 'package:teste_tecnico_target/domain/entities/user_entity.dart';

class SharedPreferencesLocalUserDataSource implements LocalUserDataSource {
  @override
  Future<Either<Failure, bool>> createAccount(UserEntity user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (await isUserExists(user.username)) {
        return Left(
            Failure("Usuário já existe. Escolha outro nome de usuário."));
      }

      prefs.setString(user.username, user.toJson());

      return const Right(true);
    } catch (e) {
      return Left(Failure('Failed to create account: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getSavedUser(String username) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString(username);

      if (jsonString != null) {
        return Right(UserEntity.fromJson(jsonString));
      }

      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to get saved user: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearUserData(String username) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(username);
      return const Right(unit);
    } catch (e) {
      return Left(Failure('Failed to clear user data: $e'));
    }
  }

  Future<bool> isUserExists(String username) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(username);
  }
}
