import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/data/datasources/local_user_datasource.dart';
import 'package:teste_tecnico_target/data/repositories/account_repository_impl.dart';
import 'package:teste_tecnico_target/domain/entities/user_entity.dart';
import 'package:teste_tecnico_target/domain/repositories/account_repository.dart';

import '../datasources/local_user_datasource_test.mocks.dart';

@GenerateMocks([LocalUserDataSource])
void main() {
  late AccountRepository accountRepository;
  late LocalUserDataSource mockLocalUserDataSource;

  setUp(() {
    mockLocalUserDataSource = MockLocalUserDataSource();
    accountRepository = AccountRepositoryImpl(mockLocalUserDataSource);
  });

  group('AccountRepositoryImpl', () {
    const username = 'test_user';
    const password = 'test_password';

    test('createAccount deve retornar Right(true) quando bem-sucedido',
        () async {
      final user = UserEntity(username: username, password: password);
      when(mockLocalUserDataSource.createAccount(user))
          .thenAnswer((_) async => const Right(true));

      final result = await accountRepository.createAccount(user);

      expect(result, equals(const Right(true)));
      verify(mockLocalUserDataSource.createAccount(user)).called(1);
    });

    test('createAccount deve retornar Left(Failure) em caso de falha',
        () async {
      final user = UserEntity(username: username, password: password);
      final failure = Failure('Erro ao criar conta');
      when(mockLocalUserDataSource.createAccount(user))
          .thenAnswer((_) async => Left(failure));

      final result = await accountRepository.createAccount(user);

      expect(result, equals(Left(failure)));
      verify(mockLocalUserDataSource.createAccount(user)).called(1);
    });

    test('getSavedUser deve retornar Right(UserEntity) quando bem-sucedido',
        () async {
      when(mockLocalUserDataSource.getSavedUser(username)).thenAnswer(
          (_) async =>
              Right(UserEntity(username: username, password: password)));

      final result = await accountRepository.getSavedUser(username);

      expect(result,
          equals(Right(UserEntity(username: username, password: password))));
      verify(mockLocalUserDataSource.getSavedUser(username)).called(1);
    });

    test('getSavedUser deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao obter usuário salvo');
      when(mockLocalUserDataSource.getSavedUser(username))
          .thenAnswer((_) async => Left(failure));

      final result = await accountRepository.getSavedUser(username);

      expect(result, equals(Left(failure)));
      verify(mockLocalUserDataSource.getSavedUser(username)).called(1);
    });

    test('logout deve retornar Right(unit) quando bem-sucedido', () async {
      when(mockLocalUserDataSource.clearUserData(username))
          .thenAnswer((_) async => const Right(unit));

      final result = await accountRepository.logout(username);

      expect(result, equals(const Right(unit)));
      verifyNever(mockLocalUserDataSource.clearUserData(username));
    });

    test('logout deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao fazer logout');
      when(mockLocalUserDataSource.clearUserData(username))
          .thenAnswer((_) async => Left(failure));

      await accountRepository.logout(username);

      verifyNever(mockLocalUserDataSource.clearUserData(username));
    });
  });
}
