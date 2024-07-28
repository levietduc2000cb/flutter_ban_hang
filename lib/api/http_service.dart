import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class HttpService {
  final String baseUrl = Constants.baseUrl;

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.get(url);
  }

  Future<http.Response> post(String endpoint,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.post(url,
        headers: headers, body: body, encoding: encoding);
  }
}
