import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/domain/entities/data_entity.dart';

import 'data_datasource_test.mocks.dart';

@GenerateMocks([DataDataSource])
void main() {
  late DataDataSource dataDataSource;

  setUpAll(() {
    dataDataSource = MockDataDataSource();
  });

  group('DataDataSource', () {
    const userId = 'user123';
    const newData = 'Novos Dados';
    const oldData = 'Dados Antigos';

    test('loadData deve retornar Right(List<DataEntity>) quando bem-sucedido',
        () async {
      final testDataList = [DataEntity('1', 'Teste')];
      when(dataDataSource.loadData(userId))
          .thenAnswer((_) async => Right(testDataList));

      final result = await dataDataSource.loadData(userId);

      expect(result, equals(Right(testDataList)));
      verify(dataDataSource.loadData(userId)).called(1);
    });

    test('loadData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao carregar dados');
      when(dataDataSource.loadData(userId))
          .thenAnswer((_) async => Left(failure));

      final result = await dataDataSource.loadData(userId);

      expect(result, equals(Left(failure)));
      verify(dataDataSource.loadData(userId)).called(1);
    });

    test('loadData deve lançar uma exceção em caso de erro', () async {
      when(dataDataSource.loadData(userId)).thenThrow(Exception('Erro'));

      expect(
        () async => await dataDataSource.loadData(userId),
        throwsA(isA<Exception>()),
      );
    });

    test('saveData deve retornar Right(unit) quando bem-sucedido', () async {
      when(dataDataSource.saveData(userId, newData))
          .thenAnswer((_) async => const Right(unit));

      final result = await dataDataSource.saveData(userId, newData);

      expect(result, equals(const Right(unit)));
      verify(dataDataSource.saveData(userId, newData)).called(1);
    });

    test('saveData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao salvar dados');
      when(dataDataSource.saveData(userId, newData))
          .thenAnswer((_) async => Left(failure));

      final result = await dataDataSource.saveData(userId, newData);

      expect(result, equals(Left(failure)));
      verify(dataDataSource.saveData(userId, newData)).called(1);
    });

    test('saveData deve lançar uma exceção em caso de erro', () async {
      when(dataDataSource.saveData(userId, newData))
          .thenThrow(Exception('Erro'));

      expect(
        () async => await dataDataSource.saveData(userId, newData),
        throwsA(isA<Exception>()),
      );
    });

    test('editData deve retornar Right(unit) quando bem-sucedido', () async {
      when(dataDataSource.editData(userId, oldData, newData))
          .thenAnswer((_) async => const Right(unit));

      final result = await dataDataSource.editData(userId, oldData, newData);

      expect(result, equals(const Right(unit)));
      verify(dataDataSource.editData(userId, oldData, newData)).called(1);
    });

    test('editData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao editar dados');
      when(dataDataSource.editData(userId, oldData, newData))
          .thenAnswer((_) async => Left(failure));

      final result = await dataDataSource.editData(userId, oldData, newData);

      expect(result, equals(Left(failure)));
      verify(dataDataSource.editData(userId, oldData, newData)).called(1);
    });

    test('editData deve lançar uma exceção em caso de erro', () async {
      when(dataDataSource.editData(userId, oldData, newData))
          .thenThrow(Exception('Erro'));

      expect(
        () async => await dataDataSource.editData(userId, oldData, newData),
        throwsA(isA<Exception>()),
      );
    });

    test('deleteData deve retornar Right(unit) quando bem-sucedido', () async {
      when(dataDataSource.deleteData(userId, oldData))
          .thenAnswer((_) async => const Right(unit));

      final result = await dataDataSource.deleteData(userId, oldData);

      expect(result, equals(const Right(unit)));
      verify(dataDataSource.deleteData(userId, oldData)).called(1);
    });

    test('deleteData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao excluir dados');
      when(dataDataSource.deleteData(userId, oldData))
          .thenAnswer((_) async => Left(failure));

      final result = await dataDataSource.deleteData(userId, oldData);

      expect(result, equals(Left(failure)));
      verify(dataDataSource.deleteData(userId, oldData)).called(1);
    });

    test('deleteData deve lançar uma exceção em caso de erro', () async {
      when(dataDataSource.deleteData(userId, oldData))
          .thenThrow(Exception('Erro'));

      expect(
        () async => await dataDataSource.deleteData(userId, oldData),
        throwsA(isA<Exception>()),
      );
    });
  });
}
