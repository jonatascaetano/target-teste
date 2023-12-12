import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/domain/entities/data_entity.dart';
import 'package:teste_tecnico_target/domain/repositories/data_repository.dart';

import 'data_repository_test.mocks.dart';

@GenerateMocks([DataRepository])
void main() {
  group('DataRepository', () {
    late DataRepository mockRepository;
    late String userId;
    late String newData;
    late String oldData;
    late String testData;

    setUp(() {
      mockRepository = MockDataRepository();
      userId = 'user123';
      newData = 'Novos Dados';
      oldData = 'Dados Antigos';
      testData = 'Teste';
    });

    test('loadData deve retornar Right(List<DataEntity>)', () async {
      final testDataList = [DataEntity(userId, testData)];
      when(mockRepository.loadData(userId))
          .thenAnswer((_) async => Right(testDataList));

      final result = await mockRepository.loadData(userId);

      expect(result, equals(Right(testDataList)));
      verify(mockRepository.loadData(userId)).called(1);
    });

    test('loadData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao carregar dados');
      when(mockRepository.loadData(userId))
          .thenAnswer((_) async => Left(failure));

      final result = await mockRepository.loadData(userId);

      expect(result, equals(Left(failure)));
      verify(mockRepository.loadData(userId)).called(1);
    });

    test('saveData deve retornar Right(unit) em caso de sucesso', () async {
      when(mockRepository.saveData(userId, newData))
          .thenAnswer((_) async => const Right(unit));

      final result = await mockRepository.saveData(userId, newData);

      expect(result, equals(const Right(unit)));
      verify(mockRepository.saveData(userId, newData)).called(1);
    });

    test('saveData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao salvar dados');
      when(mockRepository.saveData(userId, newData))
          .thenAnswer((_) async => Left(failure));

      final result = await mockRepository.saveData(userId, newData);

      expect(result, equals(Left(failure)));
      verify(mockRepository.saveData(userId, newData)).called(1);
    });

    test('editData deve retornar Right(unit) em caso de sucesso', () async {
      when(mockRepository.editData(userId, oldData, newData))
          .thenAnswer((_) async => const Right(unit));

      final result = await mockRepository.editData(userId, oldData, newData);

      expect(result, equals(const Right(unit)));
      verify(mockRepository.editData(userId, oldData, newData)).called(1);
    });

    test('editData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao editar dados');
      when(mockRepository.editData(userId, oldData, newData))
          .thenAnswer((_) async => Left(failure));

      final result = await mockRepository.editData(userId, oldData, newData);

      expect(result, equals(Left(failure)));
      verify(mockRepository.editData(userId, oldData, newData)).called(1);
    });

    test('deleteData deve retornar Right(unit) em caso de sucesso', () async {
      when(mockRepository.deleteData(userId, testData))
          .thenAnswer((_) async => const Right(unit));

      final result = await mockRepository.deleteData(userId, testData);

      expect(result, equals(const Right(unit)));
      verify(mockRepository.deleteData(userId, testData)).called(1);
    });

    test('deleteData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao excluir dados');
      when(mockRepository.deleteData(userId, testData))
          .thenAnswer((_) async => Left(failure));

      final result = await mockRepository.deleteData(userId, testData);

      expect(result, equals(Left(failure)));
      verify(mockRepository.deleteData(userId, testData)).called(1);
    });
  });
}
