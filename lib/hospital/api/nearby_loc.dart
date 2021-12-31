
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../models/hospital_models.dart';
import 'geocode.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';


class LocationService {
  static final _locationService = new LocationService();

  static LocationService get() {
    return _locationService;
  }

  final String apiKey = "AIzaSyCMYMD-QqZODL8ieHv_Femo2wQ0_Fih4tw";

  String detailUrl =
      "https://maps.googleapis.com/maps/api/place/details/json?placeid=&key=";
  String urlutama = 
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?radius=5000&type=hospital&language=bahasa-indonesia&name=rumah-sakit&";
      // "https://maps.googleapis.com/maps/api/place/nearbysearch/json?radius=5000&type=hospital&";


  Future<List<HospitalData>> getNearbyPlaces() async {
    var placesData = <HospitalData>[];
    Position latLng = await determinePosition().catchError((e) {
      stdout.writeln("errroroororoororor");
      return e;
    });
    var url = urlutama + "location=${latLng.latitude},${latLng.longitude}&key=$apiKey";

    // url = urlutama + "location=-6.355591163059973,106.83026601059707&key=${API_KEY}";
    var reponse = await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    List data = json.decode(reponse.body)["results"];
    
    for(final res in data) {
        var detailUrl2 = detailUrl + apiKey + "&place_id=";
        var response = await http
          .get(Uri.parse(detailUrl2 + res["place_id"]));
        var result = json.decode(response.body)["result"];
        stdout.writeln("masuk");
        try {
          if(result["photos"] != null){
            stdout.writeln(result);
            String photoRef = result['photos'][1]['photo_reference'];
            placesData.add (new HospitalData(
              name: result["name"], 
              id: result["place_id"], 
              address: result["formatted_address"], 
              url: result["url"], 
              photoUrl: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=320&maxheight=200&photo_reference=$photoRef&key=$apiKey"
            ));
          }
        // }
        } catch (e) {
          stdout.writeln(e);
        }{
        
      }
    }
    stdout.writeln(placesData.length);
    stdout.writeln(placesData);
    return placesData;
  }
}