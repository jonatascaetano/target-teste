// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_capture_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DataCaptureStore on _DataCaptureStoreBase, Store {
  late final _$stateAtom =
      Atom(name: '_DataCaptureStoreBase.state', context: context);

  @override
  DataCaptureState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(DataCaptureState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$capturedDataAtom =
      Atom(name: '_DataCaptureStoreBase.capturedData', context: context);

  @override
  ObservableList<String> get capturedData {
    _$capturedDataAtom.reportRead();
    return super.capturedData;
  }

  @override
  set capturedData(ObservableList<String> value) {
    _$capturedDataAtom.reportWrite(value, super.capturedData, () {
      super.capturedData = value;
    });
  }

  late final _$formKeyAtom =
      Atom(name: '_DataCaptureStoreBase.formKey', context: context);

  @override
  GlobalKey<FormState> get formKey {
    _$formKeyAtom.reportRead();
    return super.formKey;
  }

  @override
  set formKey(GlobalKey<FormState> value) {
    _$formKeyAtom.reportWrite(value, super.formKey, () {
      super.formKey = value;
    });
  }

  late final _$dataControllerAtom =
      Atom(name: '_DataCaptureStoreBase.dataController', context: context);

  @override
  TextEditingController get dataController {
    _$dataControllerAtom.reportRead();
    return super.dataController;
  }

  @override
  set dataController(TextEditingController value) {
    _$dataControllerAtom.reportWrite(value, super.dataController, () {
      super.dataController = value;
    });
  }

  late final _$dataFocusNodeAtom =
      Atom(name: '_DataCaptureStoreBase.dataFocusNode', context: context);

  @override
  FocusNode get dataFocusNode {
    _$dataFocusNodeAtom.reportRead();
    return super.dataFocusNode;
  }

  @override
  set dataFocusNode(FocusNode value) {
    _$dataFocusNodeAtom.reportWrite(value, super.dataFocusNode, () {
      super.dataFocusNode = value;
    });
  }

  late final _$loadDataAsyncAction =
      AsyncAction('_DataCaptureStoreBase.loadData', context: context);

  @override
  Future<void> loadData() {
    return _$loadDataAsyncAction.run(() => super.loadData());
  }

  late final _$saveDataAsyncAction =
      AsyncAction('_DataCaptureStoreBase.saveData', context: context);

  @override
  Future<void> saveData(String newData) {
    return _$saveDataAsyncAction.run(() => super.saveData(newData));
  }

  late final _$editDataAsyncAction =
      AsyncAction('_DataCaptureStoreBase.editData', context: context);

  @override
  Future<void> editData(String oldData, String newData) {
    return _$editDataAsyncAction.run(() => super.editData(oldData, newData));
  }

  late final _$deleteDataAsyncAction =
      AsyncAction('_DataCaptureStoreBase.deleteData', context: context);

  @override
  Future<void> deleteData(String data) {
    return _$deleteDataAsyncAction.run(() => super.deleteData(data));
  }

  @override
  String toString() {
    return '''
state: ${state},
capturedData: ${capturedData},
formKey: ${formKey},
dataController: ${dataController},
dataFocusNode: ${dataFocusNode}
    ''';
  }
}
