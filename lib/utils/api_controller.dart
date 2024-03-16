import 'package:flutter/material.dart';
import 'package:http/http.dart';

class APIController {
  static Future<Response> getData(String url) async {
    Response response = await get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
      return response;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
