import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalCard extends StatelessWidget {
  final String nama;
  final String alamat;
  final String urlFoto;
  final String urlMaps;

  HospitalCard(this.nama, this.alamat, this.urlFoto, this.urlMaps);

  void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchURL(this.urlMaps),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20,20,20,0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(130, 140, 246, 1).withOpacity(0.7),
                Color.fromRGBO(130, 140, 246, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(children: [
            ClipRRect(child: Image.network(this.urlFoto),
            borderRadius: BorderRadius.circular(15),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                this.nama,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white
                  ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 15,),
            Text(
              this.alamat,
              style: TextStyle(color: Colors.white)
            )
          ],)
        ),
      ),
    );
  }
}