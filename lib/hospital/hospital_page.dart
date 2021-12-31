import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'models/hospital_models.dart';
import 'api/nearby_loc.dart';
import 'widgets/hospital_card.dart';

class PlacesPage extends StatefulWidget {
  @override
  State createState() => new Placestate();
}

class Placestate extends State<PlacesPage> {
  String? _currentPlaceId;

  @override
  Widget build(BuildContext context) {

      // onItemTapped= ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new PlaceDetailPage(_currentPlaceId)));

    // TODO: implement build
    return new Scaffold(
        backgroundColor: Colors.black,
        appBar: new AppBar(
          title: new Text("Nearby Hospital"),
          backgroundColor: Color.fromRGBO(130, 140, 246, 1),
          
        ),
        body:_createContent(),
      );
  }
final _biggerFont = const TextStyle(fontSize: 18.0);
  Widget _createContent() {

    if(_places.length == 0){
      return new Center(
        child: CircularProgressIndicator(color: Color.fromRGBO(130, 140, 246, 1)),
      );
    }

    else{
      return new ListView(
         children: _places.map((f){
           return new HospitalCard(f.name, f.address, f.photoUrl, f.url);
          //  return new Card(
          //     child: new ListTile(
          //     title: new Text(f.name,style: _biggerFont,),
          //      subtitle: new Text(f.name),
          //     onTap: () => launchURL(f.url),
          //  ),
          //  )
          //   ;
         }).toList(),
      );
    }
  }
  List<HospitalData> _places = [];
  @override
  void initState() {
    super.initState();
    if (_places.length == 0) {
      LocationService.get().getNearbyPlaces().then((data) {
        stdout.writeln("11");
        this.setState(() {
          _places = data;
        });
      });
    }

    //print("count: "+_places.length.toString());
  }

    void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
    }
}