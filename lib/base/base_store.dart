

import 'package:mobx/mobx.dart';
part 'base_store.g.dart';

class BaseStore = _BaseStore with _$BaseStore;
  abstract class  _BaseStore with Store{
  ///Observe for Error message
  @observable
   String errorMessage = '';

  ///Show snack bar if is error is true
  @observable
  bool isError = false;

  ///Show Alert message if this true
  @observable
  bool isAlert = false;

  ///Observer for loading progresbar
  @observable
  bool shouldLoad = false;

  ///Observer for if internet available
  @observable
  bool isInternetAvailable = true;
  ///this action is used once error is gone
  @action
  void disableError() {
    isError = false;
  }

  ///this action is used once error is gone
  @action
  void disableAlert() {
    isAlert = false;
  }

}