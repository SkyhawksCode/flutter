// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  final _$shouldObscurePasswordAtom =
      Atom(name: '_LoginStore.shouldObscurePassword');

  @override
  bool get shouldObscurePassword {
    _$shouldObscurePasswordAtom.reportRead();
    return super.shouldObscurePassword;
  }

  @override
  set shouldObscurePassword(bool value) {
    _$shouldObscurePasswordAtom.reportWrite(value, super.shouldObscurePassword,
        () {
      super.shouldObscurePassword = value;
    });
  }

  final _$doLoginAsyncAction = AsyncAction('_LoginStore.doLogin');

  @override
  Future doLogin(String userName, String password) {
    return _$doLoginAsyncAction.run(() => super.doLogin(userName, password));
  }

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  dynamic showPassword() {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.showPassword');
    try {
      return super.showPassword();
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
shouldObscurePassword: ${shouldObscurePassword}
    ''';
  }
}
