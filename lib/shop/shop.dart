import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/Hyperlink.dart' as bebas;

class Barang {
  final String pilihan;
  final String gambar;
  final String link;

  Barang({
    required this.pilihan,
    required this.gambar,
    required this.link,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      pilihan: json['pilihan'],
      gambar: json['gambar'],
      link: json['link'],
    );
  }
}

List<Barang> parseBarang(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Barang>((json) => Barang.fromJson(json)).toList();
}

Future<List<Barang>> fetchBarang() async {
  final response =
      await http.get(Uri.parse('https://covid19-panic-button.herokuapp.com/shop/ambil_konten'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return compute(parseBarang, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Barang');
  }
}

Future postData(String tanggapan) async {
   final response = await http.post(Uri.parse('https://covid19-panic-button.herokuapp.com/shop/post_konten'),
   headers: <String, String>{
     'Content-Type': 'application/json;charset=UTF-8',
   },
   body: jsonEncode(<String, String>{
     'tanggapan': tanggapan
   }));

   if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Perlengkapan Isoman',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Dapatkan barang yang Anda perlukan di sini'),
//     );
//   }
// }

class ShopPage extends StatefulWidget {
  ShopPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
 String _dropDownButtonValue = '';

 late Future<List<Barang>> futureBarang;

  @override
  void initState() {
    super.initState();
    futureBarang = fetchBarang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff828cf6),
      appBar: AppBar(
        // title: Text(widget.title),
        backgroundColor: const Color(0xff181818),
        title: Text(widget.title), actions: <Widget>[]
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
              DropdownButton(
              focusColor: Colors.blue,
              hint: Text('Barang apa yang ingin Anda beli?'), //text shown on the button (optional)
              elevation: 3,
              items: <String>['Masker', 'Hand Sanitizer', 'Obat-obatan', 'Vitamin', 'Oximetry', 'Thermometer', 'Face Shield', 'Strap Mask']
              .map((String val) => DropdownMenuItem<String>(
                value: val,
                child: Text(val),
              ))
          .toList(),
          onChanged: (value) {
          setState(() {
          _dropDownButtonValue = value.toString();
          });
          },
          ),
          FutureBuilder<List<Barang>>(
              future: futureBarang,
              builder: (context, snapshot) {
               if (snapshot.hasData) {
                 switch(_dropDownButtonValue){
                   case "Masker":
                    return Center(
                    child: Container(
                    margin: const EdgeInsets.all(10.0),
                    width: 500.0,
                    height: 500.0,
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                    Image.network(snapshot.data![0].gambar),
                    Text(snapshot.data![0].pilihan),
                    bebas.Hyperlink(snapshot.data![0].link, "View in Shopee Store"),
                    const MyCustomForm(),
                    ]))),
                    );
                    case "Hand Sanitizer":
                    return Center(
                    child: Container(
                    margin: const EdgeInsets.all(10.0),
                    width: 500.0,
                    height: 500.0,
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                    Image.network(snapshot.data![1].gambar),
                    Text(snapshot.data![1].pilihan),
                    bebas.Hyperlink(snapshot.data![1].link, "View in Shopee Store"),
                    const MyCustomForm(),
                    ]))),
                    );
                    case "Obat-obatan":
                    return Center(
                    child: Container(
                    margin: const EdgeInsets.all(10.0),
                    width: 500.0,
                    height: 500.0,
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                    Image.network(snapshot.data![2].gambar),
                    Text(snapshot.data![2].pilihan),
                    bebas.Hyperlink(snapshot.data![2].link, "View in Shopee Store"),
                    const MyCustomForm(),
                    ]))),
                    );
                    case "Vitamin":
                    return Center(
                    child: Container(
                    margin: const EdgeInsets.all(10.0),
                    width: 500.0,
                    height: 500.0,
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                    Image.network(snapshot.data![3].gambar),
                    Text(snapshot.data![3].pilihan),
                    bebas.Hyperlink(snapshot.data![3].link, "View in Shopee Store"),
                    const MyCustomForm(),
                    ]))),
                    );
                    case "Oximetry":
                    return Center(
                    child: Container(
                    margin: const EdgeInsets.all(10.0),
                    width: 500.0,
                    height: 500.0,
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                    Image.network(snapshot.data![4].gambar),
                    Text(snapshot.data![4].pilihan),
                    bebas.Hyperlink(snapshot.data![4].link, "View in Shopee Store"),
                    const MyCustomForm(),
                    ]))),
                    );
                    case "Thermometer":
                    return Center(
                    child: Container(
                    margin: const EdgeInsets.all(10.0),
                    width: 500.0,
                    height: 500.0,
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                    Image.network(snapshot.data![5].gambar),
                    Text(snapshot.data![5].pilihan),
                    bebas.Hyperlink(snapshot.data![5].link, "View in Shopee Store"),
                    const MyCustomForm(),
                    ]))),
                    );
                    case "Face Shield":
                    return Center(
                    child: Container(
                    margin: const EdgeInsets.all(10.0),
                    width: 500.0,
                    height: 500.0,
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                    Image.network(snapshot.data![6].gambar),
                    Text(snapshot.data![6].pilihan),
                    bebas.Hyperlink(snapshot.data![6].link, "View in Shopee Store"),
                    const MyCustomForm(),
                    ]))),
                    );
                    case "Strap Mask":
                    return Center(
                    child: Container(
                    margin: const EdgeInsets.all(10.0),
                    width: 500.0,
                    height: 500.0,
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                    Image.network(snapshot.data![7].gambar),
                    Text(snapshot.data![7].pilihan),
                    bebas.Hyperlink(snapshot.data![7].link, "View in Shopee Store"),
                    const MyCustomForm(),
                    ]))),
                    );
                   default:
                 }
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
              },
              )
          ],
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String tampungValue = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Apakah Anda puas terhadap pencarian Anda?';
              }
              else {
                tampungValue = value;
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async{
                if (_formKey.currentState!.validate()) {
                  await postData(tampungValue);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Terima Kasih')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}