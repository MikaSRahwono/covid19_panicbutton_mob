import 'dart:convert';

import 'package:http/http.dart';
import 'models/data.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String postsUrl =
      "https://apicovid19indonesia-v2.vercel.app/api/indonesia/provinsi/more";

  Future<List<DataIndonesia>> getPosts() async {
    Response res = await get(Uri.parse(postsUrl));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<DataIndonesia> dataIndonesia =
          body.map((dynamic item) => DataIndonesia.fromJson(item)).toList();
      return dataIndonesia;
    } else {
      throw "Can't get posts.";
    }
  }
}

// 127.0.0.1:8000/data-covid/json

class HttpServiceDjango {
  Future<List<DataIndonesia>> getPosts() async {
    var url = Uri.parse("http://127.0.0.1:8000/data-covid/json");
    final response = await http.get(url);
    var data = jsonDecode(response.body);

    return data;
  }
}
