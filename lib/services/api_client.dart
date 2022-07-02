import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  var responseJson;

  get({required String? url,
      var params,
      required callback(int code, bool message, dynamic res)}) async {
    print("request: $url");
    print('$params');
    try {
      http.Response response = await http.get(
        Uri.parse('${url}/${params ?? ''}'),
        headers: {
          // // 'Authorization': await UserPreferences().getToken() ?? '',
          "content-type": "application/json"
        },
      );
      print("csasasa ${response.body}");
      print("code: ${response.statusCode}");
      // responseJson = _returnResponse(response);
      // print(responseJson);
      callback(response.statusCode, true, response.body);
    } on SocketException {
      callback(0, false, 'No Internet connection');
    }
  }

  post({required String? url,
      var body,
      var params,
      required callback(
          int? code, bool? message, dynamic res)}) async {
    print("request: $url");
    print('${body}');
    try {
      http.Response response = await http.post(
        Uri.parse('${url}/${params ?? ''}'),
        headers: {
          // // 'Authorization': await UserPreferences().getToken() ?? '',
          "content-type": "application/json"
        },
        body: json.encode(body),
      );
      print("code: ${response.statusCode}");
      responseJson = _returnResponse(response);
      print(responseJson);
      callback(response.statusCode, responseJson['success'], responseJson['message']);
    } on SocketException {
      callback(0, false, 'No Internet connection');
    }
  }

  put({required String? url,
    var body,
    var params,
    required callback(
        int? code, bool? message, dynamic res)}) async {
    print("request: $url");
    print('${body}');
    try {
      http.Response response = await http.put(
        Uri.parse('${url}/${params ?? ''}'),
        headers: {
          // 'Authorization': await UserPreferences().getToken() ?? '',
          "content-type": "application/json"
        },
        body: json.encode(body),
      );
      print("code: ${response.statusCode}");
      responseJson = _returnResponse(response);
      print(responseJson);
      callback(response.statusCode, responseJson['success'], responseJson['message']);
    } on SocketException {
      callback(0, false, 'No Internet connection');
    }
  }

  delete({required String? url,
      var params,
      // var body,
      required callback(
          int? code, bool? message, dynamic res)}) async {
    print("request: $url");
    // print('${body}');
    try {
      http.Response response = await http.delete(
        Uri.parse('${url}/${params}'),
        headers: {
          // 'Authorization': await UserPreferences().getToken() ?? '',
          "content-type": "application/json"
        },
        // body: json.encode(body),
      );
      print("code: ${response.statusCode}");
      responseJson = _returnResponse(response);
      callback(response.statusCode, responseJson['success'],
          responseJson['message']);
    } on SocketException {
      callback(0, false, 'No Internet connection');
    }
  }

  Future asynPost({required String? url,
    var body,
    var params,}) async {
    print("request: $url");
    print('${body}');
    try {
      http.Response response = await http.post(
        Uri.parse('${url}/${params ?? ''}'),
        headers: {
          // 'Authorization': await UserPreferences().getToken() ?? '',
          "content-type": "application/json"
        },
        body: json.encode(body),
      );
      print("code: ${response.statusCode}");
      responseJson = _returnResponse(response);
      print(responseJson);
      return responseJson;
    } on SocketException {
      responseJson['success'] = false;
      responseJson['message'] = 'No Internet connection';
      return responseJson;
    }
  }

  Future asynPut({required String? url,
    var body,
    var params,}) async {
    print("request: $url");
    print('${body}');
    try {
      http.Response response = await http.put(
        Uri.parse('${url}/${params ?? ''}'),
        headers: {
          // 'Authorization': await UserPreferences().getToken() ?? '',
          "content-type": "application/json"
        },
        body: json.encode(body),
      );
      print("code: ${response.statusCode}");
      responseJson = _returnResponse(response);
      print(responseJson);
      return responseJson;
    } on SocketException {
      responseJson['success'] = false;
      responseJson['message'] = 'No Internet connection';
      return responseJson;
    }
  }

  Future asynDelete({required String? url,
    var params,}) async {
    print("request: $url");
    try {
      http.Response response = await http.delete(
        Uri.parse('${url}/${params ?? ''}'),
        headers: {
          // 'Authorization': await UserPreferences().getToken() ?? '',
          "content-type": "application/json"
        },
      );
      print("code: ${response.statusCode}");
      responseJson = _returnResponse(response);
      print(responseJson);
      return responseJson;
    } on SocketException {
      responseJson['success'] = false;
      responseJson['message'] = 'No Internet connection';
      return responseJson;
    }
  }

  dynamic _returnResponse(http.Response response) {
    var resultsJson = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        if (resultsJson['success']) return resultsJson;
        else {
          resultsJson['message'] = resultsJson['error'];
          return resultsJson;
        }
      case 400:
        resultsJson['success'] = false;
        resultsJson['message'] = 'Bad Request Exception';
        return resultsJson;
      case 401:
      case 403:
        resultsJson['success'] = false;
        resultsJson['message'] = 'Please Sign-in First';
        return resultsJson;
      case 404:
        resultsJson['success'] = false;
        resultsJson['message'] = resultsJson['error'];
        return resultsJson;
      case 500:
      default:
        resultsJson['success'] = false;
        resultsJson['message'] =
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}';
        return resultsJson;
    }
  }
}
