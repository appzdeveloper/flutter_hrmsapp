import 'package:hrms/data/repository.dart';
import 'package:hrms/main.dart';
import 'package:hrms/models/dashboard_model.dart';
import 'package:hrms/models/chatModel.dart';
import 'package:hrms/stores/error/error_store.dart';
import 'package:hrms/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
part 'global_store.g.dart';

class GlobalStore = _GlobalStore with _$GlobalStore;

abstract class _GlobalStore with Store {
  // repository instance
  Repository repository = appComponent.getRepository();

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // store variables:-----------------------------------------------------------
  @observable
  DashboardModel dashboardData;

  // store variables:-----------------------------------------------------------
  @observable
  ChatModel chatData;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  // actions:-------------------------------------------------------------------
  @action
  Future getDashboard() async {
    loading = true;
    await repository.getDashboard().then((dashData) {
      this.dashboardData = dashData;
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

  @action
  Future getConversation() async {
    loading = true;
    await repository.getConversation().then((chatData) {
      this.chatData = chatData;
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
