// To parse this JSON data, do
//
//     final mfPaymentResponse = mfPaymentResponseFromJson(jsonString);

import 'dart:convert';

MfPaymentResponse mfPaymentResponseFromJson(String str) =>
    MfPaymentResponse.fromJson(json.decode(str));

String mfPaymentResponseToJson(MfPaymentResponse data) =>
    json.encode(data.toJson());

class MfPaymentResponse {
  MfPaymentResponse({
    this.request,
    this.response,
    this.status,
  });

  dynamic request;
  Response? response;
  Status? status;

  factory MfPaymentResponse.fromJson(Map<String, dynamic> json) =>
      MfPaymentResponse(
        request: json["REQUEST"],
        response: json["response"] == null
            ? null
            : Response.fromJson(json["response"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "REQUEST": request,
        "response": response == null ? null : response!.toJson(),
        "status": status == null ? null : status!.toJson(),
      };
}

class Response {
  Response({
    this.link,
    this.page,
  });

  String? link;
  String? page;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
      link: json["link"] == null ? null : json["link"],
      page: json["page"] == null ? null : json["page"]);

  Map<String, dynamic> toJson() => {
        "link": link == null ? null : link,
      };
}

class Status {
  Status({
    this.code,
    this.messages,
  });

  String? code;
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
