import 'package:flutter/foundation.dart';

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
  final String last_prov;

  DataDjango({
    required this.last_prov,
  });

  factory DataDjango.fromJson(Map<String, dynamic> json) {
    return DataDjango(
      last_prov: json["provinsi"] as String,
    );
  }
}
