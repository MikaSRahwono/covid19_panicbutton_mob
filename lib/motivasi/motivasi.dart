import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'model.dart';

final randomColors = [
  const Color(0xffc2ff3d), 
  const Color(0xffff3de8),
  const Color(0xff3dc2ff),
  const Color(0xff04e022),
  const Color(0xffbc83e6),
  const Color(0xffebb328),
];

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     theme: ThemeData(
//       primaryColor: Colors.black,
//       scaffoldBackgroundColor: Colors.blueGrey.shade900,
//       appBarTheme: const AppBarTheme(
//         backgroundColor: Color(0xff181818),
//         elevation: 0,
//       ),
//     ),
//     home: const MotivasiApp()
//   ));
// }

class MotivasiApp extends StatefulWidget {
  const MotivasiApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  MotivasiPage createState() => MotivasiPage();
}

class MotivasiPage extends State<MotivasiApp> {
  List<Note> notes = [];
  NoteJson dummyJson = NoteJson();
  bool isLoading = false;

  fetchData() async {
    setState(() => isLoading = true);

    notes = await dummyJson.fetchNote();
    // print(notes.length);
    // for (var i = 0; i < notes.length; i++) {
    //   var currentElement = notes[i];
    //   print(currentElement.message);
    // }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff181818),
        appBar: AppBar(
          backgroundColor: const Color(0xff181818),
          title: Text("Motivation",
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: const Color(0xff828cf6)
          )),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              color: const Color(0xff828cf6),
              iconSize: 30,
              onPressed: () {}
            )
          ]
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
          child: (isLoading) ? const CircularProgressIndicator(
            color: Color(0xff828cf6),
          ) 
          : ListView.builder(
            itemBuilder: (context, index) {
              // return Text(notes[index].message);
              return Card(
                color: randomColors[index % randomColors.length],
                child: Container(
                  // width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  constraints: const BoxConstraints(minHeight: 75),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notes[index].message,
                        // style: const TextStyle(color: Color(0xff181818)),
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff181818),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }, 
            // separatorBuilder: (context, index) {
            //   return const Divider();
            // }, 
            itemCount: notes.length
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff828cf6),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddMotivationPage()),
            );
            fetchData();
          },
          tooltip: 'Add Motivation',
          child: const Icon(Icons.add),
      ),
    );
  }
}

class AddMotivationPage extends StatefulWidget {
  const AddMotivationPage({Key? key}) : super(key: key);

  @override
  _AddMotivationPage createState() => _AddMotivationPage();
}

class _AddMotivationPage extends State<AddMotivationPage> {
  // final _formKey = GlobalKey<FormState>();
  final messageController = TextEditingController();
  String message = '';
  NoteJson postJson = NoteJson();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181818),
      appBar: AppBar(
        backgroundColor: const Color(0xff181818),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: IconButton(
              icon: const Icon(Icons.delete),
              tooltip: "Clear",
              onPressed: () {}
            )
          ),
        ]
      ),
      body: Form(
        // key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TextFormField(
            maxLines: 5,
            maxLength: 150,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Write your motivation here... (max 150 words)',
              hintStyle: GoogleFonts.poppins(
                color: Colors.white
              ),
            ),
            style: GoogleFonts.poppins(
                color: Colors.white
              ),
            controller: messageController,
            // validator: (value) {
            //   if (value == null) {
            //     return 'Tolong masukkan motivasi darimu :)';
            //   } else if (value.isEmpty) {
            //     return 'Tolong masukkan motivasi darimu :)';
            //   }
            //   return null;
            // },
          )
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff828cf6),
        onPressed: () async {
          print('pressed');
          // if (_formKey.currentState!.validate()) {
          //   message = messageController.text;

          //   // bool response =  postJson.postData(message);

          //   // if (response) {
          //   //   Navigator.pop(context);
          //   // } 
          //   Navigator.pop(context);
          // }
          if (messageController.text.isNotEmpty) {
            message = messageController.text;
            bool response = await postJson.postData(message);
          }
          
          Navigator.pop(context);
        },
        label: Text("Add motivation",
          style: GoogleFonts.poppins(
              color: Colors.white
            ),
          )
      )
    );
  }
}

// class NoteCardWidget extends StatelessWidget {
//   NoteCardWidget({ Key? key }) : super(key: key);

//   final colorBg = _lightColors[0 % _lightColors.length];

//   @override
//   Widget build(BuildContext context) {
    
//     return Card(
//       color: colorBg,
//       child: Container(
//         constraints: const BoxConstraints(minHeight: 100),
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text("Testing 1",
//               style: TextStyle(color: Color(0xff181818)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Future<NoteJson> fetchNote() async {
//   final response = await 
//     http.get(Uri.parse('http://127.0.0.1:8000/motivasi/index_json'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return NoteJson.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load note');
//   }
// }

// class NoteJson {
//   final List<Note> fields;

//   NoteJson({
//     required this.fields,
//   });

//   // factory NoteJson.fromJson(String str) => NoteJson.fromMap(json.decode(str));

//   // factory NoteJson.fromJson(Map<String, dynamic> json) => NoteJson(
//   //   fields: List<Note>.from(json['data'].map((x) => x))
//   // );

//   factory NoteJson.fromJson(Map<String, dynamic> json) {
//     return NoteJson(
//       fields: List<Note>.from(json['data'].map((x) => x))
//       );
//   }

//   Map<String, dynamic> toMap() => {
//     'fields': List<dynamic>.from(fields.map((x) => x))
//   };
// }
