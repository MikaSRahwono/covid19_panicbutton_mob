// import 'package:flutter/foundation.dart';

class DataIndonesia {
  final String provinsi;
  final int kasus;
  final int sembuh;
  final int mati;

  DataIndonesia({
    required this.provinsi,
    required this.kasus,
    required this.sembuh,
    required this.mati,
  });

  factory DataIndonesia.fromJson(Map<String, dynamic> json) {
    return DataIndonesia(
      provinsi: json["provinsi"] as String,
      kasus: json["kasus"] as int,
      sembuh: json["sembuh"] as int,
      mati: json["meninggal"] as int,
    );
  }
}

class DataDjango {
  final String lastProv;

  DataDjango({
    required this.lastProv,
  });

  factory DataDjango.fromJson(Map<String, dynamic> json) {
    return DataDjango(
      lastProv: json["provinsi"] as String,
    );
  }
}
