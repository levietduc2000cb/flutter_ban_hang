import 'dart:convert';
import 'package:ban_hang/models/user_model.dart';

import 'http_service.dart';

class UserApi {
  final httpService = HttpService();

  Future<dynamic> login(String userName, String password) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final body = {
      'username': userName,
      'password': password,
    };
    final jsonBody = json.encode(body);
    final responsive =
        await httpService.post("users/login", body: jsonBody, headers: headers);
    return responsive.body;
  }

  Future<dynamic> register(UserModel user) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final body = user.toJson();
    final jsonBody = json.encode(body);
    final responsive = await httpService.post("users/register",
        body: jsonBody, headers: headers);
    return responsive.body;
  }
}
