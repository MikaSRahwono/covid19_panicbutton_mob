// ignore_for_file: prefer_const_literals_to_create_immutables, deprecated_member_use

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'dart:developer';

class DisplayCard extends StatefulWidget {
  final positif;
  final sembuh;
  final mati;

  DisplayCard({Key? key, this.positif, this.sembuh, this.mati})
      : super(key: key);

  @override
  _DisplayCardState createState() => _DisplayCardState();
}

class _DisplayCardState extends State<DisplayCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: [
      CardPositif(angka: widget.positif),
      CardSembuh(angka: widget.sembuh),
      CardMati(angka: widget.mati)
    ]));
  }
}

class CardPositif extends StatefulWidget {
  final angka;

  CardPositif({Key? key, this.angka}) : super(key: key);
  @override
  _CardPositifState createState() => _CardPositifState();
}

class _CardPositifState extends State<CardPositif> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 105,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 7, left: 7),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(children: [
              Text("${widget.angka}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ]),
            Row(children: [
              const Text("Positif",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  )),
            ])
          ]),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.orange,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(0, 1),
            )
          ]),
    );
  }
}

class CardSembuh extends StatefulWidget {
  final angka;

  CardSembuh({Key? key, this.angka}) : super(key: key);
  @override
  _CardSembuhState createState() => _CardSembuhState();
}

class _CardSembuhState extends State<CardSembuh> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 105,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 7, left: 7),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(children: [
              Text("${widget.angka}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ]),
            Row(children: [
              const Text("Sembuh",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  )),
            ])
          ]),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.green,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(0, 1),
            )
          ]),
    );
  }
}

class CardMati extends StatefulWidget {
  final angka;

  CardMati({Key? key, this.angka}) : super(key: key);
  @override
  _CardMatiState createState() => _CardMatiState();
}

class _CardMatiState extends State<CardMati> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 105,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 7, left: 7),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(children: [
              Text("${widget.angka}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ]),
            Row(children: [
              const Text("Meninggal",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  )),
            ])
          ]),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(0, 1),
            )
          ]),
    );
  }
}
