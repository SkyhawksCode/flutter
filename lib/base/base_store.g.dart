// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BaseStore on _BaseStore, Store {
  final _$errorMessageAtom = Atom(name: '_BaseStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$isErrorAtom = Atom(name: '_BaseStore.isError');

  @override
  bool get isError {
    _$isErrorAtom.reportRead();
    return super.isError;
  }

  @override
  set isError(bool value) {
    _$isErrorAtom.reportWrite(value, super.isError, () {
      super.isError = value;
    });
  }

  final _$isAlertAtom = Atom(name: '_BaseStore.isAlert');

  @override
  bool get isAlert {
    _$isAlertAtom.reportRead();
    return super.isAlert;
  }

  @override
  set isAlert(bool value) {
    _$isAlertAtom.reportWrite(value, super.isAlert, () {
      super.isAlert = value;
    });
  }

  final _$shouldLoadAtom = Atom(name: '_BaseStore.shouldLoad');

  @override
  bool get shouldLoad {
    _$shouldLoadAtom.reportRead();
    return super.shouldLoad;
  }

  @override
  set shouldLoad(bool value) {
    _$shouldLoadAtom.reportWrite(value, super.shouldLoad, () {
      super.shouldLoad = value;
    });
  }

  final _$isInternetAvailableAtom =
      Atom(name: '_BaseStore.isInternetAvailable');

  @override
  bool get isInternetAvailable {
    _$isInternetAvailableAtom.reportRead();
    return super.isInternetAvailable;
  }

  @override
  set isInternetAvailable(bool value) {
    _$isInternetAvailableAtom.reportWrite(value, super.isInternetAvailable, () {
      super.isInternetAvailable = value;
    });
  }

  final _$_BaseStoreActionController = ActionController(name: '_BaseStore');

  @override
  void disableError() {
    final _$actionInfo = _$_BaseStoreActionController.startAction(
        name: '_BaseStore.disableError');
    try {
      return super.disableError();
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void disableAlert() {
    final _$actionInfo = _$_BaseStoreActionController.startAction(
        name: '_BaseStore.disableAlert');
    try {
      return super.disableAlert();
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
isError: ${isError},
isAlert: ${isAlert},
shouldLoad: ${shouldLoad},
isInternetAvailable: ${isInternetAvailable}
    ''';
  }
}
