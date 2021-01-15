import 'dart:convert';
import 'package:http/http.dart';

class ApiManager {
  final String _baseUrl = "http://192.168.1.127:5000/";

  Future<dynamic> postProgram(Map prograMap) async {
    print("Construyendo el post");
    var _url = _baseUrl + "programa/";
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response = await post(_url, headers: headers, body:json.encode(prograMap));
    int statusCode = response.statusCode;
    print(response.body);
    return response.body;     
  }
  
}