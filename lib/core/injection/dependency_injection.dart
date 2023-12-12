import 'package:get_it/get_it.dart';
import 'package:teste_tecnico_target/data/datasources/data_datasource.dart';
import 'package:teste_tecnico_target/data/datasources/local_user_datasource.dart';
import 'package:teste_tecnico_target/data/datasources/shared_preferences_data_datasource.dart';
import 'package:teste_tecnico_target/data/datasources/shared_preferences_local_user_datasource.dart';
import 'package:teste_tecnico_target/data/repositories/account_repository_impl.dart';
import 'package:teste_tecnico_target/data/repositories/data_repository_impl.dart';
import 'package:teste_tecnico_target/domain/repositories/account_repository.dart';
import 'package:teste_tecnico_target/domain/repositories/data_repository.dart';
import 'package:teste_tecnico_target/domain/usecases/auth_usecase.dart';
import 'package:teste_tecnico_target/domain/usecases/data_usecase.dart';
import 'package:teste_tecnico_target/presentation/ViewModels/user_viewmodel.dart.dart';
import 'package:teste_tecnico_target/presentation/blocs/auth_cubit.dart';
import 'package:teste_tecnico_target/presentation/blocs/data_capture_cubit.dart';
import 'package:teste_tecnico_target/presentation/stores/auth_store.dart';
import 'package:teste_tecnico_target/presentation/stores/data_capture_store.dart';

final GetIt getIt = GetIt.instance;

void setupInjection() {
  // datasource
  getIt.registerLazySingleton<LocalUserDataSource>(
      () => SharedPreferencesLocalUserDataSource());
  getIt.registerLazySingleton<DataDataSource>(
      () => SharedPreferencesDataDataSource());

  //repositories
  getIt.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(getIt()));
  getIt
      .registerLazySingleton<DataRepository>(() => DataRepositoryImpl(getIt()));

  // UseCase
  getIt.registerLazySingleton<AuthUseCase>(() => AuthUseCase(getIt()));
  getIt.registerLazySingleton<DataUseCase>(() => DataUseCase(getIt()));

  // ViewModel
  getIt.registerLazySingleton<UserViewModel>(() => UserViewModel());

  // Cubit
  getIt.registerFactory(() => AuthCubit(getIt(), getIt()));
  getIt.registerFactory(() => DataCaptureCubit(getIt(), getIt()));

  // Stores
  getIt.registerFactory(() => DataCaptureStore(getIt(), getIt()));
  getIt.registerFactory(() => AuthStore(getIt(), getIt()));
}
