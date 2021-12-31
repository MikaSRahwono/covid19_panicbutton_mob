import 'dart:convert';
import 'package:http/http.dart' as http;

class Note {
  final int idNote;
  final String message;

  Note({
    required this.idNote,
    required this.message
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      idNote: json['id'], 
      message: json['message']
    );
  }

  // Map<String, dynamic> toMap() => {
  //   'idNote': idNote,
  //   'message': message,
  // };

}

class NoteJson {
  // http://covid19-panic-button.herokuapp.com/motivasi/index_json
  // http://127.0.0.1:8000/motivasi/index_json
  final url = 'http://covid19-panic-button.herokuapp.com/motivasi/index_json';

  Future fetchNote() async {
    final response = await http.get(Uri.parse(url),
    headers: {
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          });

    print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Iterable it = jsonDecode(response.body);
      List<Note> notes = it.map((e) => Note.fromJson(e)).toList();
      return notes;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load motivation');
    }
  }

  Future postData(String message) async {
    // http://covid19-panic-button.herokuapp.com/motivasi/post_flutter
    // http://127.0.0.1:8000/motivasi/post_flutter
    final response = await http.post(Uri.parse('http://covid19-panic-button.herokuapp.com/motivasi/post_flutter'),
      // body: {'message' : message},
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        },
      body: jsonEncode(<String, String>{
      'message': message,
      })
    );

    print(message);

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}