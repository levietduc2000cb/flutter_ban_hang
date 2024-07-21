import 'dart:convert';
import 'http_service.dart';

class UserApi {

  final httpService = HttpService();

  Future<dynamic> login(String userName, String password) async{
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final body = {
      'username': userName,
      'password': password,
    };
    final jsonBody = json.encode(body);
    final responsive = await httpService.post("users/login", body: jsonBody, headers: headers);
    return responsive.body;
  }
}