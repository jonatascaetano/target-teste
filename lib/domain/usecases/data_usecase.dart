import 'package:dartz/dartz.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/domain/entities/data_entity.dart';
import 'package:teste_tecnico_target/domain/repositories/data_repository.dart';

class DataUseCase {
  final DataRepository _repository;

  DataUseCase(this._repository);

  Future<Either<Failure, List<DataEntity>>> loadData(String userId) async {
    return _repository.loadData(userId);
  }

  Future<Either<Failure, Unit>> saveData(String userId, String newData) async {
    return _repository.saveData(userId, newData);
  }

  Future<Either<Failure, Unit>> editData(
      String userId, String oldData, String newData) async {
    return _repository.editData(userId, oldData, newData);
  }

  Future<Either<Failure, Unit>> deleteData(String userId, String data) async {
    return _repository.deleteData(userId, data);
  }
}
