import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/domain/entities/data_entity.dart';

class SharedPreferencesDataDataSource implements DataDataSource {
  @override
  Future<Either<Failure, List<DataEntity>>> loadData(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final capturedData = prefs.getStringList('$userId-capturedData') ?? [];
      final dataEntities =
          capturedData.map((data) => DataEntity(userId, data)).toList();
      return Right(dataEntities);
    } catch (e) {
      return Left(Failure('Failed to load data: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveData(String userId, String newData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final capturedData = prefs.getStringList('$userId-capturedData') ?? [];
      capturedData.add(newData);
      await prefs.setStringList('$userId-capturedData', capturedData);
      return const Right(unit);
    } catch (e) {
      return Left(Failure('Failed to save data: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> editData(
      String userId, String oldData, String newData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final capturedData = prefs.getStringList('$userId-capturedData') ?? [];
      final index = capturedData.indexOf(oldData);
      if (index != -1) {
        capturedData[index] = newData;
        await prefs.setStringList('$userId-capturedData', capturedData);
      }
      return const Right(unit);
    } catch (e) {
      return Left(Failure('Failed to edit data: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteData(String userId, String data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final capturedData = prefs.getStringList('$userId-capturedData') ?? [];
      capturedData.remove(data);
      await prefs.setStringList('$userId-capturedData', capturedData);
      return const Right(unit);
    } catch (e) {
      return Left(Failure('Failed to delete data: $e'));
    }
  }
}
