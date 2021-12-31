// ignore_for_file: prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:developer';
import 'package:covid19_panicbutton_mob/data_covid/widget/card_page.dart';
import 'package:covid19_panicbutton_mob/data_covid/widget/cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'http_service.dart';
import 'package:covid19_panicbutton_mob/data_covid/models/data.dart';

// class MyApp extends StatelessWidget {
//   static const blackPBP = Color(0xFF181818);
//   static const whitePBP = Color(0xFFF4F6FA);
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'PBP Lab',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: whitePBP,
//       ),
//       home: HomePage(),
//     );
//   }
// }

class DataCovidPage extends StatefulWidget {
  const DataCovidPage({Key? key}) : super(key: key);

  @override
  _DataCovidPageState createState() => _DataCovidPageState();
}

class _DataCovidPageState extends State<DataCovidPage> {
  final _formKey = GlobalKey<FormState>();
  var _autoValidate = AutovalidateMode.disabled;
  String search = "null";

  static const blackPBP = Color(0xFF181818);
  static const purplePBP = Color(0xFF828cf6);
  static const whitePBP = Color(0xFFF4F6FA);

  List<DataIndonesia> datas = [];
  List<DataIndonesia> datasDjango = [];
  HttpService httpService = HttpService();
  HttpServiceDjango httpServiceDjango = HttpServiceDjango();
  var kasus;
  var sembuh;
  var mati;
  var provinsiSaatIni;
  TextEditingController controller = TextEditingController();

  getIndex0() async {
    print("masook asink");
    datasDjango = await httpServiceDjango.getPosts();

    for (var i = 0; i < 1; i++) {
      provinsiSaatIni = datasDjango[i];
    }
    print(provinsiSaatIni);
    setState(() {});
    return provinsiSaatIni;
  }

  @override
  void initState() {
    print("masuk init");
    getIndex0();
    fetchDataDjango(provinsiSaatIni);
    super.initState();
  }

  fetchDataDjango(String search) async {
    datas = await httpService.getPosts();
    print("masukkk fetchdatadjango");
    print(search);
    datas.forEach((element) {
      print(element.provinsi);
      if (element.provinsi.toLowerCase() == search.toLowerCase()) {
        kasus = element.kasus;
        sembuh = element.sembuh;
        mati = element.mati;
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: purplePBP),
          title:
              const Text("sum ting wong", style: TextStyle(color: purplePBP)),
          backgroundColor: blackPBP,
        ),
        body: Center(
            child: Column(children: <Widget>[
          SizedBox(height: 30),
          Text("Covid di Provinsi mu",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 30),
          DisplayCard(positif: kasus, sembuh: sembuh, mati: mati),
          SizedBox(height: 50),
          // Form(
          //     autovalidateMode: _autoValidate,
          //     key: _formKey,
          //     child: Column(children: [
          //       TextFormField(
          //           decoration: const InputDecoration(
          //             prefixIcon: Icon(Icons.search),
          //             hintText: 'Cari provinsimu...',
          //             border: OutlineInputBorder(
          //                 borderSide: BorderSide(color: purplePBP)),
          //             filled: true,
          //             errorStyle: TextStyle(fontSize: 15),
          //           ),
          //           // onChanged: (value) => setState(() => search = value),
          //           onChanged: (value) {
          //             search = value.toLowerCase();
          //           },
          //           validator: (value) {
          //             if (value!.isEmpty) {
          //               return 'Please enter a Provinsi';
          //             } else {
          //               return null;
          //             }
          //           }),
          //       const SizedBox(height: 5),
          //       ElevatedButton(
          //         style: ButtonStyle(
          //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //               RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(18),
          //                   side: const BorderSide(color: purplePBP))),
          //           backgroundColor: MaterialStateProperty.all<Color>(blackPBP),
          //         ),
          //         onPressed: () {
          //           final isValid = _formKey.currentState!.validate();
          //           if (isValid) {
          //             // TODO Perform search
          //             if (search == 'jakarta') {
          //               search = "dki jakarta";
          //               print(search);
          //             }
          //             fetchData(search);
          //             setState(() {
          //               print("masuk setstate");
          //             });
          //           } else {
          //             setState(() {
          //               _autoValidate = AutovalidateMode.always;
          //             });
          //           }
          //         },
          //         child: const Text('Search',
          //             style: TextStyle(
          //               color: purplePBP,
          //               fontSize: 18,
          //             )),
          //       )
          //     ])),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: const BorderSide(color: purplePBP))),
              backgroundColor: MaterialStateProperty.all<Color>(blackPBP),
            ),
            child: Text("Cari Data Covid Indonesia",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: purplePBP,
                  fontSize: 18,
                )),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => PostPage()));
            },
          ),
        ])));
  }
}

setState(String? Function() param0) {}
