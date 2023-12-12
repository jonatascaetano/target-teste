import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_target/domain/usecases/data_usecase.dart';
import 'package:teste_tecnico_target/presentation/ViewModels/user_viewmodel.dart.dart';
import 'package:teste_tecnico_target/presentation/blocs/data_capture_state.dart';

class DataCaptureCubit extends Cubit<DataCaptureState> {
  final DataUseCase _dataUseCase;
  final UserViewModel _userViewModel;

  DataCaptureCubit(this._dataUseCase, this._userViewModel)
      : super(DataCaptureInitialState());

  void loadData() async {
    var result =
        await _dataUseCase.loadData(_userViewModel.loggedInUser!.username);
    result.fold((l) {
      emit(DataCaptureErrorState("Erro ao carregar dados"));
    }, (r) {
      final capturedData = r;
      emit(DataCaptureLoadedState(
          capturedData.map((data) => data.data).toList()));
    });
  }

  void saveData(String newData) async {
    var result = await _dataUseCase.saveData(
        _userViewModel.loggedInUser!.username, newData);
    result.fold((l) {
      emit(DataCaptureErrorState("Erro ao salvar dados"));
    }, (r) {
      loadData();
    });
  }

  void editData(String oldData, String newData) async {
    var result = await _dataUseCase.editData(
        _userViewModel.loggedInUser!.username, oldData, newData);
    result.fold((l) {
      emit(DataCaptureErrorState("Erro ao editar dados"));
    }, (r) {
      loadData();
    });
  }

  void deleteData(String data) async {
    var result = await _dataUseCase.deleteData(
        _userViewModel.loggedInUser!.username, data);
    result.fold((l) {
      emit(DataCaptureErrorState("Erro ao excluir dados"));
    }, (r) {
      loadData();
    });
  }
}
