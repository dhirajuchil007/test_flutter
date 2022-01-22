// To parse this JSON data, do
//
//     final getSchemesResponse = getSchemesResponseFromJson(jsonString);

import 'dart:convert';

SchemeData getSchemesResponseFromJson(String str) =>
    SchemeData.fromJson(json.decode(str));

String getSchemesResponseToJson(SchemeData data) =>
    json.encode(data.toJson());

class SchemeData {
  SchemeData({
    required this.meta,
    required this.data,
    required this.status,
  });

  Meta meta;
  List<Datum> data;
  String status;

  factory SchemeData.fromJson(Map<String, dynamic> json) =>
      SchemeData(
        meta: Meta.fromJson(json["meta"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta == null ? null : meta.toJson(),
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status == null ? null : status,
      };
}

class Datum {
  Datum({
    required this.date,
    required this.nav,
  });

  String date;
  String nav;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"] == null ? null : json["date"],
        nav: json["nav"] == null ? null : json["nav"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "nav": nav == null ? null : nav,
      };
}

class Meta {
  Meta({
    required this.fundHouse,
    required this.schemeType,
    required this.schemeCategory,
    required this.schemeCode,
    required this.schemeName,
  });

  String fundHouse;
  String schemeType;
  String schemeCategory;
  int schemeCode;
  String schemeName;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        fundHouse: json["fund_house"] == null ? null : json["fund_house"],
        schemeType: json["scheme_type"] == null ? null : json["scheme_type"],
        schemeCategory:
            json["scheme_category"] == null ? null : json["scheme_category"],
        schemeCode: json["scheme_code"] == null ? null : json["scheme_code"],
        schemeName: json["scheme_name"] == null ? null : json["scheme_name"],
      );

  Map<String, dynamic> toJson() => {
        "fund_house": fundHouse == null ? null : fundHouse,
        "scheme_type": schemeType == null ? null : schemeType,
        "scheme_category": schemeCategory == null ? null : schemeCategory,
        "scheme_code": schemeCode == null ? null : schemeCode,
        "scheme_name": schemeName == null ? null : schemeName,
      };
}
