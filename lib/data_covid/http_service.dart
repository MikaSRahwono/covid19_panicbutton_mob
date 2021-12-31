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
  Future getPosts() async {
    final url = "https://covid19-panic-button.herokuapp.com/data-covid/json";

    print("masuk httpservice");
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
    print(response);
    // print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      String body = jsonDecode(response.body)['last_prov'];
      print(body);
      return body;
    } else {
      throw Exception("Cant get Posts.");
    }
    // var data = jsonDecode(response.body);
    // print("masoook" + data);
    // return data;
  }
}
