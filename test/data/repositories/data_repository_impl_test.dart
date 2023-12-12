import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/data/repositories/data_repository_impl.dart';
import 'package:teste_tecnico_target/domain/entities/data_entity.dart';

import '../datasources/data_datasource_test.mocks.dart';

@GenerateMocks([DataDataSource])
void main() {
  late DataRepositoryImpl dataRepository;
  late DataDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockDataDataSource();
    dataRepository = DataRepositoryImpl(mockDataSource);
  });

  group('DataRepositoryImpl', () {
    const userId = 'user123';
    const newData = 'Novos Dados';
    const oldData = 'Dados Antigos';

    test('loadData deve retornar Right(List<DataEntity>)', () async {
      final expectedData = [DataEntity(userId, newData)];
      when(mockDataSource.loadData(userId))
          .thenAnswer((_) async => Right(expectedData));

      final result = await dataRepository.loadData(userId);

      expect(result, equals(Right(expectedData)));
      verify(mockDataSource.loadData(userId)).called(1);
    });

    test('loadData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao carregar dados');
      when(mockDataSource.loadData(userId))
          .thenAnswer((_) async => Left(failure));

      final result = await dataRepository.loadData(userId);

      expect(result, equals(Left(failure)));
      verify(mockDataSource.loadData(userId)).called(1);
    });

    test('saveData deve retornar Right(unit) em caso de sucesso', () async {
      when(mockDataSource.saveData(userId, newData))
          .thenAnswer((_) async => const Right(unit));

      final result = await dataRepository.saveData(userId, newData);

      expect(result, equals(const Right(unit)));
      verify(mockDataSource.saveData(userId, newData)).called(1);
    });

    test('saveData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao salvar dados');
      when(mockDataSource.saveData(userId, newData))
          .thenAnswer((_) async => Left(failure));

      final result = await dataRepository.saveData(userId, newData);

      expect(result, equals(Left(failure)));
      verify(mockDataSource.saveData(userId, newData)).called(1);
    });

    test('editData deve retornar Right(unit) em caso de sucesso', () async {
      when(mockDataSource.editData(userId, oldData, newData))
          .thenAnswer((_) async => const Right(unit));

      final result = await dataRepository.editData(userId, oldData, newData);

      expect(result, equals(const Right(unit)));
      verify(mockDataSource.editData(userId, oldData, newData)).called(1);
    });

    test('editData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao editar dados');
      when(mockDataSource.editData(userId, oldData, newData))
          .thenAnswer((_) async => Left(failure));

      final result = await dataRepository.editData(userId, oldData, newData);

      expect(result, equals(Left(failure)));
      verify(mockDataSource.editData(userId, oldData, newData)).called(1);
    });

    test('deleteData deve retornar Right(unit) em caso de sucesso', () async {
      when(mockDataSource.deleteData(userId, oldData))
          .thenAnswer((_) async => const Right(unit));

      final result = await dataRepository.deleteData(userId, oldData);

      expect(result, equals(const Right(unit)));
      verify(mockDataSource.deleteData(userId, oldData)).called(1);
    });

    test('deleteData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao excluir dados');
      when(mockDataSource.deleteData(userId, oldData))
          .thenAnswer((_) async => Left(failure));

      final result = await dataRepository.deleteData(userId, oldData);

      expect(result, equals(Left(failure)));
      verify(mockDataSource.deleteData(userId, oldData)).called(1);
    });
  });
}
