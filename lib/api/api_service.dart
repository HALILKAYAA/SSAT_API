import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/login_model.dart';

// API POST METHODS FOR GET JSON

class APIService {

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    //Testing URL FOR LOGİN PAGE
    //String url = "https://reqres.in/api/login";
    String url = "www.chathostssat.com/api/session";
    final response = await http.post(url, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

class APIServiceFinal {

  Future<AIResponseModel> login(AIResponseModel requestModel) async {
    String url2 = "www.chathostssat.com/api/session/{session-id}/messages";
    final response = await http.post(url2, body: requestModel.toString());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return AIResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to final load text!!!');
    }
  }
}