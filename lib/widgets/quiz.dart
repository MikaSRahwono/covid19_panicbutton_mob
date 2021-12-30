import 'package:covid19_panicbutton_mob/cookie_request.dart';
import 'package:covid19_panicbutton_mob/widgets/lulus.dart';
import 'package:covid19_panicbutton_mob/widgets/tidak_lulus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: QuizApp());
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  TextEditingController nama = TextEditingController();
  Color col = const Color(0xFF181818);
  Color acc = const Color(0xFF818CF8);

  int index = 0;
  List<String> question = [
    "Halo, silahkan masukan nama anda dibawah ini",
    "Apakah indera penciuman atau perasa anda pernah hilang?",
    "Apakah anda pernah kontak dengan orang yang terkonfirmasi kasus COVID?",
    "Apakah anda pernah mengalami gejala dibawah ini? (Bisa lebih dari satu)",
    "Apakah saturasi oksigen anda kurang dari 92%?",
    "Apakah anda pernah mengalami sesak napas dalam beberapa hari terakhir?",
    "Apakah pernyataan dibawah ini ada yang menggambarkan diri anda?",
    "Pilih Provinsi anda"
  ];

  List<Widget> options = [];
  Widget op = Container();
  List<int> val = [0, 0, 0, 0, 0, 0];
  int g = 0;
  List<String> gejala = [
    "Demam",
    "Lemah Lesu",
    "Kelelahan",
    "Penurunan Kadar Oksigen",
    "Pusing",
    "Batuk Kering",
    "Sakit Tenggorokan",
    "Sinusitis",
    "Hidung Meler",
    "Hidung Tersumbat",
    "Sakit Kepala",
    "Nyeri Otot",
    "Nyeri Sendi",
    "Mata Merah",
    "Nyeri Punggung Bawah",
    "Nyeri Punggung Atas",
    "Sakit Kaki",
    "Sakit Leher Rahim",
    "Nyeri Dibelakang Mata",
    "Diare",
    "Mual",
    "Sakit Perut",
  ];
  List<bool> bgejala = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  List<String> rentan = [
    "Petugas kesehatan",
    "Anak-anak (dibawah 18)",
    "Penderita penyakit jantung",
    "Penderita diabetes",
    "Penderita kanker",
    "Obesitas",
    "Perokok (atau mantan perokok)",
    "Ibu hamil",
    "Kondisi kesehatan mental",
    "Penderita penyakit pernapasan",
    "Penderita penyakit kronis",
  ];

  List<bool> brentan = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  String selectedProv = "Aceh";
  List<String> provs = [
    "Aceh",
    "Bali",
    "Bangka Belitung",
    "Banten",
    "Bengkulu",
    "DKI Jakarta",
    "Daerah Istimewa Yogyakarta",
    "Gorontalo",
    "Jambi",
    "Jawa Barat",
    "Jawa Tengah",
    "Jawa Timur",
    "Kalimantan Barat",
    "Kalimantan Selatan",
    "Kalimantan Tengah",
    "Kalimantan Timur",
    "Kalimantan Utara",
    "Kepulauan Riau",
    "Lampung",
    "Maluku",
    "Maluku Utara",
    "Nusa Tenggara Barat",
    "Nusa Tenggara Timur",
    "Papua",
    "Papua Barat",
    "Riau",
    "Sulawesi Barat",
    "Sulawesi Selatan",
    "Sulawesi Tengah",
    "Sulawesi Tenggara",
    "Sulawesi Utara",
    "Sumatera Barat",
    "Sumatera Selatan",
    "Sumatera Utara",
  ];

  List<DropdownMenuItem> generateItems(List<String> provs) {
    List<DropdownMenuItem> items = [];
    for (var item in provs) {
      items.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    }
    return items;
  }

  setup() {
    options = [
      Container(
        margin: const EdgeInsets.all(20),
        child: TextField(
          controller: nama,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'Nama',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListTile(
                  title: const Text(
                    "Ya",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<int>(
                    activeColor: acc,
                    value: 6,
                    groupValue: val[0],
                    onChanged: (newValue) {
                      setState(() {
                        val[0] = newValue!;
                      });
                    },
                  )),
              ListTile(
                  title: const Text(
                    "Sebagian",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<int>(
                    activeColor: acc,
                    value: 5,
                    groupValue: val[0],
                    onChanged: (int? newValue) {
                      setState(() {
                        val[0] = newValue!;
                      });
                    },
                  )),
              ListTile(
                  title: const Text(
                    "Tidak",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<int>(
                    activeColor: acc,
                    value: 0,
                    groupValue: val[0],
                    onChanged: (newValue) {
                      setState(() {
                        val[0] = newValue!;
                      });
                    },
                  )),
            ],
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListTile(
                  title: const Text(
                    "Ya, dengan keluarga",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<int>(
                    activeColor: acc,
                    value: 4,
                    groupValue: val[1],
                    onChanged: (newValue) {
                      setState(() {
                        val[1] = newValue!;
                      });
                    },
                  )),
              ListTile(
                  title: const Text(
                    "Ya, dengan rekan kerja",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<int>(
                    activeColor: acc,
                    value: 1,
                    groupValue: val[1],
                    onChanged: (int? newValue) {
                      setState(() {
                        val[1] = newValue!;
                      });
                    },
                  )),
              ListTile(
                  title: const Text(
                    "Tidak",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<int>(
                    activeColor: acc,
                    value: 0,
                    groupValue: val[1],
                    onChanged: (newValue) {
                      setState(() {
                        val[1] = newValue!;
                      });
                    },
                  )),
            ],
          ),
        ),
      ),
      Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.white,
            ),
            child: Column(
              children: [
                for (int i = 0; i < gejala.length; i++)
                  CheckboxListTile(
                      title: Text(
                        gejala[i],
                        style: TextStyle(color: Colors.white),
                      ),
                      value: bgejala[i],
                      onChanged: (newValue) {
                        bgejala[i] = newValue!;
                        int valGejala = 0;
                        for (var item in bgejala) {
                          if (item) valGejala += 3;
                        }

                        setState(() {
                          bgejala[i] = newValue;
                          val[2] = valGejala;
                        });
                      })
              ],
            ),
          )),
      Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListTile(
                  title: const Text(
                    "Ya",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<int>(
                    activeColor: acc,
                    value: 5,
                    groupValue: val[5],
                    onChanged: (newValue) {
                      setState(() {
                        val[5] = newValue!;
                      });
                    },
                  )),
              ListTile(
                  title: const Text(
                    "Tidak",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<int>(
                    activeColor: acc,
                    value: 0,
                    groupValue: val[2],
                    onChanged: (int? newValue) {
                      setState(() {
                        val[2] = newValue!;
                      });
                    },
                  )),
              ListTile(
                  title: const Text(
                    "Tidak tahu",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<int>(
                    activeColor: acc,
                    value: 1,
                    groupValue: val[2],
                    onChanged: (newValue) {
                      setState(() {
                        val[2] = 0;
                      });
                    },
                  )),
            ],
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListTile(
                  title: const Text(
                    "Ya",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<int>(
                    activeColor: acc,
                    value: 5,
                    groupValue: val[3],
                    onChanged: (newValue) {
                      setState(() {
                        val[3] = newValue!;
                      });
                    },
                  )),
              ListTile(
                  title: const Text(
                    "Tidak",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<int>(
                    activeColor: acc,
                    value: 0,
                    groupValue: val[3],
                    onChanged: (int? newValue) {
                      setState(() {
                        val[3] = newValue!;
                      });
                    },
                  )),
            ],
          ),
        ),
      ),
      Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.white,
            ),
            child: Column(
              children: [
                for (int i = 0; i < brentan.length; i++)
                  CheckboxListTile(
                      title: Text(
                        rentan[i],
                        style: TextStyle(color: Colors.white),
                      ),
                      value: brentan[i],
                      onChanged: (newValue) {
                        brentan[i] = newValue!;
                        int valGejala = 0;
                        for (var item in brentan) {
                          if (item) valGejala += 100;
                        }

                        setState(() {
                          brentan[i] = newValue;
                          val[4] = valGejala;
                        });
                      })
              ],
            ),
          )),
      Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.white,
              canvasColor: col,
            ),
            child: Column(
              children: [
                DropdownButton<String>(
                  value: selectedProv,
                  style: TextStyle(color: Colors.white),
                  items: provs.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                  onChanged: (item) {
                    setState(() {
                      selectedProv = item!;
                    });
                  },
                )
              ],
            ),
          )),
    ];

    op = options[index];
  }

  @override
  Widget build(BuildContext context) {
    setup();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quiz App"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          color: col,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  question[index],
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              AnimatedSwitcher(child: op, duration: Duration(seconds: 1)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        index--;
                        if (index < 0) index = 0;
                        print(val);
                        setState(() {
                          op = options[index];
                        });
                      },
                      child: const Text('Back')),
                  ElevatedButton(
                      onPressed: () {
                        index++;
                        print(nama.text);
                        if (index == options.length) {
                          int sum =
                              val.reduce((value, element) => value + element);
                          CookieRequest quizClient = new CookieRequest();
                          quizClient.post(
                              'https://covid19-panic-button.herokuapp.com/quiz/mobile',
                              <String, String>{
                                'nama': nama.text,
                                'prov': selectedProv,
                                'isCovid': sum.toString()
                              });

                          print(selectedProv);
                          if (sum >= 6) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const TidakLulusQuiz();
                            }));
                          } else {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const LulusQuiz();
                            }));
                          }
                          index = 0;
                          return;
                        } else {
                          print(val);
                          setState(() {
                            op = options[index];
                          });
                        }
                      },
                      child: const Text('Next'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
