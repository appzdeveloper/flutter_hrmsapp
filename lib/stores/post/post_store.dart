import 'package:hrms/data/repository.dart';
import 'package:hrms/main.dart';
import 'package:hrms/models/post/post_list.dart';
import 'package:hrms/stores/error/error_store.dart';
import 'package:hrms/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {

  // repository instance
  Repository repository = appComponent.getRepository();

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // store variables:-----------------------------------------------------------
  @observable
  PostsList postsList;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  // actions:-------------------------------------------------------------------
  @action
  Future getPosts() async {
    loading = true;
    repository.getPosts().then((postsList) {
      this.postsList = postsList;
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