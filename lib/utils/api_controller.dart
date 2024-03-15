import 'package:flutter/material.dart';
import 'package:http/http.dart';

class APIController {
  static Future<Response> getData(String url) async {
    Response response = await get(Uri.parse(url), headers: {
      "X-RapidAPI-Key": "1b63d53889msh9cdef25c3a2e7d8p1a62dfjsn45b897dbfc5a",
      "X-RapidAPI-Host": "bhagavad-gita3.p.rapidapi.com"
    });
    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
      return response;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
