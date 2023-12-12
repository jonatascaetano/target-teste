import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/data_usecase.dart';
import '../ViewModels/user_viewmodel.dart.dart';
import '../blocs/data_capture_state.dart';

part 'data_capture_store.g.dart';

// ignore: library_private_types_in_public_api
class DataCaptureStore = _DataCaptureStoreBase with _$DataCaptureStore;

abstract class _DataCaptureStoreBase with Store {
  final DataUseCase _dataUseCase;
  final UserViewModel _userViewModel;

  _DataCaptureStoreBase(this._dataUseCase, this._userViewModel) {
    loadData();
    dataFocusNode.requestFocus();
  }

  @observable
  DataCaptureState state = DataCaptureInitialState();

  @observable
  ObservableList<String> capturedData = ObservableList<String>();

  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @observable
  TextEditingController dataController = TextEditingController();

  @observable
  FocusNode dataFocusNode = FocusNode();

  @action
  Future<void> loadData() async {
    var result =
        await _dataUseCase.loadData(_userViewModel.loggedInUser!.username);
    result.fold((l) {
      state = DataCaptureErrorState("Erro ao carregar dados");
    }, (r) {
      final data = r;
      capturedData = ObservableList.of(data.map((d) => d.data).toList());
      state = DataCaptureLoadedState(capturedData);
    });
  }

  @action
  Future<void> saveData(String newData) async {
    var result = await _dataUseCase.saveData(
        _userViewModel.loggedInUser!.username, newData);
    result.fold((l) {
      state = DataCaptureErrorState("Erro ao salvar dados");
    }, (r) async {
      dataController.clear();
      await loadData();
    });
  }

  @action
  Future<void> editData(String oldData, String newData) async {
    var result = await _dataUseCase.editData(
        _userViewModel.loggedInUser!.username, oldData, newData);
    result.fold((l) {
      state = DataCaptureErrorState("Erro ao editar dados");
    }, (r) async {
      await loadData();
    });
  }

  @action
  Future<void> deleteData(String data) async {
    var result = await _dataUseCase.deleteData(
        _userViewModel.loggedInUser!.username, data);
    result.fold((l) {
      state = DataCaptureErrorState("Erro ao excluir dados");
    }, (r) async {
      await loadData();
    });
  }
}
