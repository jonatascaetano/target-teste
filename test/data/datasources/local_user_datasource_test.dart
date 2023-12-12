import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/data/datasources/local_user_datasource.dart';
import 'package:teste_tecnico_target/domain/entities/user_entity.dart';

import 'local_user_datasource_test.mocks.dart';

@GenerateMocks([LocalUserDataSource])
void main() {
  late LocalUserDataSource localUserDataSource;

  setUpAll(() {
    localUserDataSource = MockLocalUserDataSource();
  });

  group('LocalUserDataSource', () {
    const username = 'john_doe';
    const password = 'password123';

    test('createAccount deve retornar Right(true) quando bem-sucedido',
        () async {
      final user = UserEntity(username: username, password: password);
      when(localUserDataSource.createAccount(user))
          .thenAnswer((_) async => const Right(true));

      final result = await localUserDataSource.createAccount(user);

      expect(result, equals(const Right(true)));
      verify(localUserDataSource.createAccount(user)).called(1);
    });

    test('createAccount deve retornar Left(Failure) em caso de falha',
        () async {
      final user = UserEntity(username: username, password: password);
      final failure = Failure('Erro ao criar conta');
      when(localUserDataSource.createAccount(user))
          .thenAnswer((_) async => Left(failure));

      final result = await localUserDataSource.createAccount(user);

      expect(result, equals(Left(failure)));
      verify(localUserDataSource.createAccount(user)).called(1);
    });

    test('createAccount deve lançar uma exceção em caso de erro', () async {
      final user = UserEntity(username: username, password: password);
      when(localUserDataSource.createAccount(user))
          .thenThrow(Exception('Erro'));

      expect(
        () async => await localUserDataSource.createAccount(user),
        throwsA(isA<Exception>()),
      );
    });

    test('getSavedUser deve retornar Right(UserEntity) quando bem-sucedido',
        () async {
      when(localUserDataSource.getSavedUser(username)).thenAnswer((_) async =>
          Right(UserEntity(username: username, password: password)));

      final result = await localUserDataSource.getSavedUser(username);

      expect(result,
          equals(Right(UserEntity(username: username, password: password))));
      verify(localUserDataSource.getSavedUser(username)).called(1);
    });

    test('getSavedUser deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao obter usuário salvo');
      when(localUserDataSource.getSavedUser(username))
          .thenAnswer((_) async => Left(failure));

      final result = await localUserDataSource.getSavedUser(username);

      expect(result, equals(Left(failure)));
      verify(localUserDataSource.getSavedUser(username)).called(1);
    });

    test('getSavedUser deve lançar uma exceção em caso de erro', () async {
      when(localUserDataSource.getSavedUser(username))
          .thenThrow(Exception('Erro'));

      expect(
        () async => await localUserDataSource.getSavedUser(username),
        throwsA(isA<Exception>()),
      );
    });

    test('clearUserData deve retornar Right(unit) quando bem-sucedido',
        () async {
      when(localUserDataSource.clearUserData(username))
          .thenAnswer((_) async => const Right(unit));

      final result = await localUserDataSource.clearUserData(username);

      expect(result, equals(const Right(unit)));
      verify(localUserDataSource.clearUserData(username)).called(1);
    });

    test('clearUserData deve retornar Left(Failure) em caso de falha',
        () async {
      final failure = Failure('Erro ao limpar dados do usuário');
      when(localUserDataSource.clearUserData(username))
          .thenAnswer((_) async => Left(failure));

      final result = await localUserDataSource.clearUserData(username);

      expect(result, equals(Left(failure)));
      verify(localUserDataSource.clearUserData(username)).called(1);
    });

    test('clearUserData deve lançar uma exceção em caso de erro', () async {
      when(localUserDataSource.clearUserData(username))
          .thenThrow(Exception('Erro'));

      expect(
        () async => await localUserDataSource.clearUserData(username),
        throwsA(isA<Exception>()),
      );
    });
  });
}
