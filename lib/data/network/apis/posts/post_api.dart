import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hrms/data/network/constants/endpoints.dart';
import 'package:hrms/data/network/dio_client.dart';
import 'package:hrms/data/network/rest_client.dart';
import 'package:hrms/models/Messages/Messages.dart';
import 'package:hrms/models/chatModel.dart';
import 'package:hrms/models/dashboard_model.dart';
import 'package:hrms/models/post/post_list.dart';

class PostApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  PostApi(this._dioClient, this._restClient);

  // Returns list of post in response
  Future<PostsList> getPosts() async {
    try {
      final res = await _dioClient.post(Endpoints.inboxList);
      return PostsList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

// User authentication
  Future<Object> login(username, password) async {
    try {
      // final username = 'username';
      // final password = 'password';
      final credentials = '$username:$password';
      final stringToBase64 = utf8.fuse(base64);
      final encodedCredentials = stringToBase64.encode(credentials);
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader: "Basic $encodedCredentials",
      };

      final res = await _dioClient.post(Endpoints.authenticate,
          options: Options(contentType: ContentType.json, headers: headers));
      return res;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns list of messages in response
  Future getMessages() async {
    try {
      final username = 'test1';
      final password = 'test1';
      final credentials = '$username:$password';
      final stringToBase64 = utf8.fuse(base64);
      final encodedCredentials = stringToBase64.encode(credentials);
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader: "Basic $encodedCredentials",
      };

      var res = await _dioClient.post(Endpoints.inboxList,
          options: Options(headers: headers));
      return MessageModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  /// Returns list of chat conversation messages in response
  Future getConversation() async {
    try {
      final username = 'test1';
      final password = 'test1';
      final credentials = '$username:$password';
      final stringToBase64 = utf8.fuse(base64);
      final encodedCredentials = stringToBase64.encode(credentials);
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader: "Basic $encodedCredentials",
      };

      var res = await _dioClient.post(Endpoints.chatList,
          options: Options(headers: headers));
      return ChatModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns Dashboard data in response
  Future getDashboard() async {
    try {
      final username = 'test1';
      final password = 'test1';
      final credentials = '$username:$password';
      final stringToBase64 = utf8.fuse(base64);
      final encodedCredentials = stringToBase64.encode(credentials);
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader: "Basic $encodedCredentials",
      };

      var res = await _dioClient.post(Endpoints.dashboardData,
          options: Options(headers: headers));
      return DashboardModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// sample api call with default rest client
//  Future<PostsList> getPosts() {
//
//    return _restClient
//        .get(Endpoints.getPosts)
//        .then((dynamic res) => PostsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}
