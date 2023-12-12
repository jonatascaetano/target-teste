// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStoreBase, Store {
  late final _$stateAtom = Atom(name: '_AuthStoreBase.state', context: context);

  @override
  AuthState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AuthState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$userControllerAtom =
      Atom(name: '_AuthStoreBase.userController', context: context);

  @override
  TextEditingController get userController {
    _$userControllerAtom.reportRead();
    return super.userController;
  }

  @override
  set userController(TextEditingController value) {
    _$userControllerAtom.reportWrite(value, super.userController, () {
      super.userController = value;
    });
  }

  late final _$passwordControllerAtom =
      Atom(name: '_AuthStoreBase.passwordController', context: context);

  @override
  TextEditingController get passwordController {
    _$passwordControllerAtom.reportRead();
    return super.passwordController;
  }

  @override
  set passwordController(TextEditingController value) {
    _$passwordControllerAtom.reportWrite(value, super.passwordController, () {
      super.passwordController = value;
    });
  }

  late final _$formKeyAtom =
      Atom(name: '_AuthStoreBase.formKey', context: context);

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

  late final _$loginAsyncAction =
      AsyncAction('_AuthStoreBase.login', context: context);

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$createAccountAsyncAction =
      AsyncAction('_AuthStoreBase.createAccount', context: context);

  @override
  Future<void> createAccount() {
    return _$createAccountAsyncAction.run(() => super.createAccount());
  }

  late final _$_AuthStoreBaseActionController =
      ActionController(name: '_AuthStoreBase', context: context);

  @override
  void logout() {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.logout');
    try {
      return super.logout();
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
userController: ${userController},
passwordController: ${passwordController},
formKey: ${formKey}
    ''';
  }
}
