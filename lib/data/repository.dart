import 'dart:async';

import 'package:hrms/data/local/datasources/post/post_datasource.dart';
import 'package:hrms/data/sharedpref/shared_preference_helper.dart';
import 'package:hrms/models/Messages/Messages.dart';
import 'package:hrms/models/post/post.dart';
import 'package:hrms/models/post/post_list.dart';
import 'package:sembast/sembast.dart';

import 'local/constants/db_constants.dart';
import 'network/apis/posts/post_api.dart';

class Repository {
  // data source object
  final PostDataSource _postDataSource;

  // api objects
  final PostApi _postApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._postApi, this._sharedPrefsHelper, this._postDataSource);
  // TODOs : check if no internet then get data from dataSource
  // Post: ---------------------------------------------------------------------
  Future<PostsList> getPosts() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _postDataSource.count() > 0
        ? _postDataSource
            .getPostsFromDb()
            .then((postsList) => postsList)
            .catchError((error) => throw error)
        : _postApi.getPosts().then((postsList) {
            postsList.posts.forEach((post) {
              _postDataSource.insert(post);
            });

            return postsList;
          }).catchError((error) => throw error);
  }

  Future<List<Post>> findPostById(int id) {
    //creating filter
    List<Filter> filters = List();

    //check to see if dataLogsType is not null
    if (id != null) {
      Filter dataLogTypeFilter = Filter.equal(DBConstants.FIELD_ID, id);
      filters.add(dataLogTypeFilter);
    }

    //making db call
    return _postDataSource
        .getAllSortedByFilter(filters: filters)
        .then((posts) => posts)
        .catchError((error) => throw error);
  }

  Future<int> insert(Post post) => _postDataSource
      .insert(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> update(Post post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> delete(Post post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);

  // Messages: ---------------------------------------------------------------------
  Future getMessages() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _postApi.getMessages().then((messageslist) {
      return (messageslist != null ? messageslist : {});
    }).catchError((error) => throw error);
  }

  //Dashboard Detail: ---------------------------------------------------------------------
  Future getDashboard() async {
    return await _postApi.getDashboard().then((dashboardData) {
      return (dashboardData != null ? dashboardData : {});
    }).catchError((error) => throw error);
  }

  //Chat Conversation: ---------------------------------------------------------------------
  Future getConversation() async {
    return await _postApi.getConversation().then((chatData) {
      return (chatData != null ? chatData : {});
    }).catchError((error) => throw error);
  }
}
