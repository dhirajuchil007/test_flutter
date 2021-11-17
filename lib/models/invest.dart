// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

InvestResponse welcomeFromJson(String str) => InvestResponse.fromJson(json.decode(str));

String welcomeToJson(InvestResponse data) => json.encode(data.toJson());

class InvestResponse {
  InvestResponse({
     this.mfOrderId,
    this.request,
    required this.investmentId,
    required this.status,
  });

  String? mfOrderId;
  dynamic request;
  int investmentId;
  Status? status;

  factory InvestResponse.fromJson(Map<String, dynamic> json) => InvestResponse(
        mfOrderId: json["mfOrderId"] == null ? null : json["mfOrderId"],
        request: json["REQUEST"],
        investmentId:
            json["investmentId"] == null ? null : json["investmentId"],
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "mfOrderId": mfOrderId == null ? null : mfOrderId,
        "REQUEST": request,
        "investmentId": investmentId == null ? null : investmentId,
        "status": status == null ? null : status!.toJson(),
      };
}

class Status {
  Status({
    required this.code,
    this.messages,
  });

  String code;
  List<dynamic>? messages;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"] == null ? null : json["code"],
        messages: json["messages"] == null
            ? null
            : List<dynamic>.from(json["messages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "messages": messages == null
            ? null
            : List<dynamic>.from(messages!.map((x) => x)),
      };
}
