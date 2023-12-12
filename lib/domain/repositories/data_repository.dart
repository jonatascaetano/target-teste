import 'package:dartz/dartz.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/domain/entities/data_entity.dart';

abstract class DataRepository {
  Future<Either<Failure, List<DataEntity>>> loadData(String userId);
  Future<Either<Failure, Unit>> saveData(String userId, String newData);
  Future<Either<Failure, Unit>> editData(
      String userId, String oldData, String newData);
  Future<Either<Failure, Unit>> deleteData(String userId, String data);
}
