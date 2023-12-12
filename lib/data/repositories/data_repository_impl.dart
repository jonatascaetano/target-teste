import 'package:dartz/dartz.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/domain/entities/data_entity.dart';
import 'package:teste_tecnico_target/domain/repositories/data_repository.dart';

class DataRepositoryImpl extends DataRepository {
  final DataDataSource _dataSource;

  DataRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<DataEntity>>> loadData(String userId) {
    return _dataSource.loadData(userId);
  }

  @override
  Future<Either<Failure, Unit>> saveData(String userId, String newData) {
    return _dataSource.saveData(userId, newData);
  }

  @override
  Future<Either<Failure, Unit>> editData(
      String userId, String oldData, String newData) {
    return _dataSource.editData(userId, oldData, newData);
  }

  @override
  Future<Either<Failure, Unit>> deleteData(String userId, String data) {
    return _dataSource.deleteData(userId, data);
  }
}
