import 'package:hrms/data/repository.dart';
import 'package:hrms/main.dart';
import 'package:hrms/models/Messages/Messages.dart';
import 'package:hrms/stores/error/error_store.dart';
import 'package:hrms/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'messages_store.g.dart';

class MessagesStore = _MessagesStore with _$MessagesStore;

abstract class _MessagesStore with Store {
  // repository instance
  Repository repository = appComponent.getRepository();

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // store variables:-----------------------------------------------------------
  @observable
  MessageModel messagesList;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  // actions:-------------------------------------------------------------------
  @action
  Future getMessages() async {
    loading = true;
    await repository.getMessages().then((messagesList) {
      this.messagesList = messagesList;
      loading = false;
      success = true;
      errorStore.showError = false;
    }).catchError((e) {
      loading = false;
      success = false;
      errorStore.showError = true;
      errorStore.errorMessage = DioErrorUtil.handleError(e);
      print(e);
    });
  }
}
