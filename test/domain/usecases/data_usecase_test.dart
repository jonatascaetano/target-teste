import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/domain/entities/data_entity.dart';
import 'package:teste_tecnico_target/domain/repositories/data_repository.dart';
import 'package:teste_tecnico_target/domain/usecases/data_usecase.dart';

import '../repositories/data_repository_test.mocks.dart';

@GenerateMocks([DataRepository])
void main() {
  late DataUseCase dataUseCase;
  late DataRepository mockDataRepository;

  setUp(() {
    mockDataRepository = MockDataRepository();
    dataUseCase = DataUseCase(mockDataRepository);
  });

  group('DataUseCase', () {
    const userId = 'user123';
    const newData = 'Novos Dados';
    const oldData = 'Dados Antigos';

    test('loadData deve retornar Right(List<DataEntity>)', () async {
      final testDataList = <DataEntity>[];
      when(mockDataRepository.loadData(userId))
          .thenAnswer((_) async => Right(testDataList));

      final result = await dataUseCase.loadData(userId);

      expect(result, equals(Right(testDataList)));
      verify(mockDataRepository.loadData(userId)).called(1);
    });

    test('loadData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao carregar dados');
      when(mockDataRepository.loadData(userId))
          .thenAnswer((_) async => Left(failure));

      final result = await dataUseCase.loadData(userId);

      expect(result, equals(Left(failure)));
      verify(mockDataRepository.loadData(userId)).called(1);
    });

    test('saveData deve retornar Right(unit) em caso de sucesso', () async {
      when(mockDataRepository.saveData(userId, newData))
          .thenAnswer((_) async => const Right(unit));

      final result = await dataUseCase.saveData(userId, newData);

      expect(result, equals(const Right(unit)));
      verify(mockDataRepository.saveData(userId, newData)).called(1);
    });

    test('saveData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao salvar dados');
      when(mockDataRepository.saveData(userId, newData))
          .thenAnswer((_) async => Left(failure));

      final result = await dataUseCase.saveData(userId, newData);

      expect(result, equals(Left(failure)));
      verify(mockDataRepository.saveData(userId, newData)).called(1);
    });

    test('editData deve retornar Right(unit) em caso de sucesso', () async {
      when(mockDataRepository.editData(userId, oldData, newData))
          .thenAnswer((_) async => const Right(unit));

      final result = await dataUseCase.editData(userId, oldData, newData);

      expect(result, equals(const Right(unit)));
      verify(mockDataRepository.editData(userId, oldData, newData)).called(1);
    });

    test('editData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao editar dados');
      when(mockDataRepository.editData(userId, oldData, newData))
          .thenAnswer((_) async => Left(failure));

      final result = await dataUseCase.editData(userId, oldData, newData);

      expect(result, equals(Left(failure)));
      verify(mockDataRepository.editData(userId, oldData, newData)).called(1);
    });

    test('deleteData deve retornar Right(unit) em caso de sucesso', () async {
      when(mockDataRepository.deleteData(userId, oldData))
          .thenAnswer((_) async => const Right(unit));

      final result = await dataUseCase.deleteData(userId, oldData);

      expect(result, equals(const Right(unit)));
      verify(mockDataRepository.deleteData(userId, oldData)).called(1);
    });

    test('deleteData deve retornar Left(Failure) em caso de falha', () async {
      final failure = Failure('Erro ao excluir dados');
      when(mockDataRepository.deleteData(userId, oldData))
          .thenAnswer((_) async => Left(failure));

      final result = await dataUseCase.deleteData(userId, oldData);

      expect(result, equals(Left(failure)));
      verify(mockDataRepository.deleteData(userId, oldData)).called(1);
    });
  });
}
