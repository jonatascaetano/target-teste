import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/domain/entities/user_entity.dart';
import 'package:teste_tecnico_target/domain/repositories/account_repository.dart';

import 'account_repository_test.mocks.dart';

@GenerateMocks([AccountRepository])
void main() {
  group('AccountRepository', () {
    late AccountRepository mockRepository;
    late UserEntity testUser;

    setUp(() {
      mockRepository = MockAccountRepository();
      testUser = UserEntity(username: 'test_user', password: 'test_password');
    });

    test('createAccount deve retornar Right(true) quando bem-sucedido',
        () async {
      when(mockRepository.createAccount(testUser))
          .thenAnswer((_) async => const Right(true));

      final result = await mockRepository.createAccount(testUser);

      expect(result, const Right(true));
      verify(mockRepository.createAccount(testUser)).called(1);
    });

    test('createAccount deve retornar Left(failure) em caso de falha',
        () async {
      final failure = Failure('Erro ao criar conta');
      when(mockRepository.createAccount(testUser))
          .thenAnswer((_) async => Left(failure));

      final result = await mockRepository.createAccount(testUser);

      expect(result, Left(failure));
      verify(mockRepository.createAccount(testUser)).called(1);
    });

    test('getSavedUser deve retornar Right(user) quando o usuário existe',
        () async {
      when(mockRepository.getSavedUser(testUser.username))
          .thenAnswer((_) async => Right(testUser));

      final result = await mockRepository.getSavedUser(testUser.username);

      expect(result, equals(Right(testUser)));
      verify(mockRepository.getSavedUser(testUser.username)).called(1);
    });

    test('getSavedUser deve retornar Left(failure) se o usuário não existir',
        () async {
      final failure = Failure('Usuário não encontrado');
      when(mockRepository.getSavedUser(testUser.username))
          .thenAnswer((_) async => Left(failure));

      final result = await mockRepository.getSavedUser(testUser.username);

      expect(result, equals(Left(failure)));
      verify(mockRepository.getSavedUser(testUser.username)).called(1);
    });

    test('logout deve retornar Right(unit) corretamente', () async {
      when(mockRepository.logout(testUser.username))
          .thenAnswer((_) async => const Right(unit));

      final result = await mockRepository.logout(testUser.username);

      expect(result, equals(const Right(unit)));
      verify(mockRepository.logout(testUser.username)).called(1);
    });
  });
}
