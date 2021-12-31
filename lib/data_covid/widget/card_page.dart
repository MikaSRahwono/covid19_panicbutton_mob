import 'package:covid19_panicbutton_mob/data_covid/models/data.dart';
import 'package:flutter/material.dart';

import '../http_service.dart';
import 'cards.dart';

class PostPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF828cf6)),
          title: Row(children: [
            const Text("Data Covid Indonesia",
                style: TextStyle(color: Color(0xFF828cf6))),
          ]),
          backgroundColor: Color(0xFF181818)),
      body: FutureBuilder(
          future: httpService.getPosts(),
          builder: (BuildContext context,
              AsyncSnapshot<List<DataIndonesia>> snapshot) {
            if (snapshot.hasData) {
              List<DataIndonesia>? posts = snapshot.data;
              return ListView(
                children: posts!
                    .map((DataIndonesia post) => Column(children: [
                          Text("${post.provinsi}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          DisplayCard(
                            positif: post.kasus,
                            sembuh: post.sembuh,
                            mati: post.mati,
                          ),
                          SizedBox(height: 20),
                        ]))
                    .toList(),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
