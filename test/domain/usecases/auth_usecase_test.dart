import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/domain/entities/user_entity.dart';
import 'package:teste_tecnico_target/domain/repositories/account_repository.dart';
import 'package:teste_tecnico_target/domain/usecases/auth_usecase.dart';

import '../repositories/account_repository_test.mocks.dart';

@GenerateMocks([AccountRepository])
void main() {
  group('AuthUseCase', () {
    late AuthUseCase authUseCase;
    late AccountRepository mockAccountRepository;

    setUp(() {
      mockAccountRepository = MockAccountRepository();
      authUseCase = AuthUseCase(mockAccountRepository);
    });

    test(
        'login deve retornar Right(true) para usuário existente e senha correta',
        () async {
      const username = 'test_user';
      const password = 'test_password';
      final testUser = UserEntity(username: username, password: password);

      when(mockAccountRepository.getSavedUser(username))
          .thenAnswer((_) async => Right(testUser));

      final result = await authUseCase.login(username, password);

      expect(result, equals(const Right(true)));
      verify(mockAccountRepository.getSavedUser(username)).called(1);
    });

    test('login deve retornar Left(Failure) para usuário inexistente',
        () async {
      const username = 'nonexistent_user';
      const password = 'test_password';

      when(mockAccountRepository.getSavedUser(username))
          .thenAnswer((_) async => const Right(null));

      final result = await authUseCase.login(username, password);

      expect(result.isLeft(), isTrue);
      expect(result.fold((l) => l, (_) => null), isA<Failure>());
      verify(mockAccountRepository.getSavedUser(username)).called(1);
    });

    test('login deve retornar Left(Failure) para senha incorreta', () async {
      const username = 'test_user';
      const correctPassword = 'test_password';
      const incorrectPassword = 'wrong_password';
      final testUser =
          UserEntity(username: username, password: correctPassword);

      when(mockAccountRepository.getSavedUser(username))
          .thenAnswer((_) async => Right(testUser));

      final result = await authUseCase.login(username, incorrectPassword);

      result.fold(
        (failure) {
          expect(failure, isA<Failure>());
        },
        (isLogged) {
          fail('Deveria ter retornado um Left');
        },
      );

      verify(mockAccountRepository.getSavedUser(username)).called(1);
    });

    test('login deve retornar Left(Failure) em caso de falha', () async {
      const username = 'test_user';
      const password = 'test_password';

      final failure = Failure('Erro ao realizar login');
      when(mockAccountRepository.getSavedUser(username))
          .thenAnswer((_) async => Left(failure));

      final result = await authUseCase.login(username, password);

      expect(result, equals(Left(failure)));
      verify(mockAccountRepository.getSavedUser(username)).called(1);
    });

    test('createAccount deve retornar Right(true) em caso de sucesso',
        () async {
      const username = 'test_user';
      const password = 'test_password';
      final testUser = UserEntity(username: username, password: password);

      when(mockAccountRepository.createAccount(testUser))
          .thenAnswer((_) async => const Right(true));

      final result = await authUseCase.createAccount(testUser);

      expect(result, equals(const Right(true)));
      verify(mockAccountRepository.createAccount(testUser)).called(1);
    });

    test('createAccount deve retornar Left(Failure) em caso de falha',
        () async {
      const username = 'test_user';
      const password = 'test_password';
      final testUser = UserEntity(username: username, password: password);

      final failure = Failure('Erro ao criar conta');
      when(mockAccountRepository.createAccount(testUser))
          .thenAnswer((_) async => Left(failure));

      final result = await authUseCase.createAccount(testUser);

      expect(result, equals(Left(failure)));
      verify(mockAccountRepository.createAccount(testUser)).called(1);
    });

    test('logout deve retornar Right(unit) em caso de sucesso', () async {
      const username = 'test_user';

      when(mockAccountRepository.logout(username))
          .thenAnswer((_) async => const Right(unit));

      final result = await authUseCase.logout(username);

      expect(result, equals(const Right(unit)));
      verify(mockAccountRepository.logout(username)).called(1);
    });

    test('logout deve retornar Left(Failure) em caso de falha', () async {
      const username = 'test_user';

      final failure = Failure('Erro ao realizar logout');
      when(mockAccountRepository.logout(username))
          .thenAnswer((_) async => Left(failure));

      final result = await authUseCase.logout(username);

      expect(result, equals(Left(failure)));
      verify(mockAccountRepository.logout(username)).called(1);
    });
  });
}
