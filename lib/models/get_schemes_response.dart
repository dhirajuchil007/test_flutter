// To parse this JSON data, do
//
//     final getSchemesResponse = getSchemesResponseFromJson(jsonString);

import 'dart:convert';

GetSchemesResponse getSchemesResponseFromJson(String str) => GetSchemesResponse.fromJson(json.decode(str));

String getSchemesResponseToJson(GetSchemesResponse data) => json.encode(data.toJson());

class GetSchemesResponse {
    GetSchemesResponse({
        this.request,
        this.response,
    });

    dynamic request;
    List<Response>? response;

    factory GetSchemesResponse.fromJson(Map<String, dynamic> json) => GetSchemesResponse(
        request: json["REQUEST"],
        response: json["response"] == null ? null : List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "REQUEST": request,
        "response": response == null ? null : List<dynamic>.from(response!.map((x) => x.toJson())),
    };
}

class Response {
    Response({
        this.schemeMasterId,
        this.schemeMfMappingId,
        this.schemeName,
        this.schemeType,
        this.schemeHouse,
        this.schemeCategory,
        this.schemeOtherInfo,
        this.schemeNav,
        this.schemeRating,
        this.schemeReturn,
        this.minInvestmentAmount,
        this.maxInvestmentAmount,
        this.purchaseMultiplier,
        this.additionalPurchaseMultiplier,
        this.minRedemptionAmount,
        this.defaultScheme,
        this.suggestedCategoryId,
        this.suggestedCategory,
        this.userInvestedAmount,
        this.folioAmount,
        this.currentFolioAmount,
        this.appSwitchEnable,
    });

    int? schemeMasterId;
    dynamic schemeMfMappingId;
    String? schemeName;
    int? schemeType;
    int? schemeHouse;
    int? schemeCategory;
    String? schemeOtherInfo;
    double? schemeNav;
    double? schemeRating;
    String? schemeReturn;
    int? minInvestmentAmount;
    int? maxInvestmentAmount;
    int? purchaseMultiplier;
    int? additionalPurchaseMultiplier;
    int? minRedemptionAmount;
    bool? defaultScheme;
    int? suggestedCategoryId;
    String? suggestedCategory;
    int? userInvestedAmount;
    int? folioAmount;
    int? currentFolioAmount;
    bool? appSwitchEnable;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        schemeMasterId: json["schemeMasterId"] == null ? null : json["schemeMasterId"],
        schemeMfMappingId: json["schemeMfMappingId"],
        schemeName: json["schemeName"] == null ? null : json["schemeName"],
        schemeType: json["schemeType"] == null ? null : json["schemeType"],
        schemeHouse: json["schemeHouse"] == null ? null : json["schemeHouse"],
        schemeCategory: json["schemeCategory"] == null ? null : json["schemeCategory"],
        schemeOtherInfo: json["schemeOtherInfo"] == null ? null : json["schemeOtherInfo"],
        schemeNav: json["schemeNAV"] == null ? null : json["schemeNAV"].toDouble(),
        schemeRating: json["schemeRating"] == null ? null : json["schemeRating"].toDouble(),
        schemeReturn: json["schemeReturn"] == null ? null : json["schemeReturn"],
        minInvestmentAmount: json["minInvestmentAmount"] == null ? null : json["minInvestmentAmount"],
        maxInvestmentAmount: json["maxInvestmentAmount"] == null ? null : json["maxInvestmentAmount"],
        purchaseMultiplier: json["purchaseMultiplier"] == null ? null : json["purchaseMultiplier"],
        additionalPurchaseMultiplier: json["additionalPurchaseMultiplier"] == null ? null : json["additionalPurchaseMultiplier"],
        minRedemptionAmount: json["minRedemptionAmount"] == null ? null : json["minRedemptionAmount"],
        defaultScheme: json["defaultScheme"] == null ? null : json["defaultScheme"],
        suggestedCategoryId: json["suggestedCategoryId"] == null ? null : json["suggestedCategoryId"],
        suggestedCategory: json["suggestedCategory"] == null ? null : json["suggestedCategory"],
        userInvestedAmount: json["userInvestedAmount"] == null ? null : json["userInvestedAmount"],
        folioAmount: json["folioAmount"] == null ? null : json["folioAmount"],
        currentFolioAmount: json["currentFolioAmount"] == null ? null : json["currentFolioAmount"],
        appSwitchEnable: json["appSwitchEnable"] == null ? null : json["appSwitchEnable"],
    );

    Map<String, dynamic> toJson() => {
        "schemeMasterId": schemeMasterId == null ? null : schemeMasterId,
        "schemeMfMappingId": schemeMfMappingId,
        "schemeName": schemeName == null ? null : schemeName,
        "schemeType": schemeType == null ? null : schemeType,
        "schemeHouse": schemeHouse == null ? null : schemeHouse,
        "schemeCategory": schemeCategory == null ? null : schemeCategory,
        "schemeOtherInfo": schemeOtherInfo == null ? null : schemeOtherInfo,
        "schemeNAV": schemeNav == null ? null : schemeNav,
        "schemeRating": schemeRating == null ? null : schemeRating,
        "schemeReturn": schemeReturn == null ? null : schemeReturn,
        "minInvestmentAmount": minInvestmentAmount == null ? null : minInvestmentAmount,
        "maxInvestmentAmount": maxInvestmentAmount == null ? null : maxInvestmentAmount,
        "purchaseMultiplier": purchaseMultiplier == null ? null : purchaseMultiplier,
        "additionalPurchaseMultiplier": additionalPurchaseMultiplier == null ? null : additionalPurchaseMultiplier,
        "minRedemptionAmount": minRedemptionAmount == null ? null : minRedemptionAmount,
        "defaultScheme": defaultScheme == null ? null : defaultScheme,
        "suggestedCategoryId": suggestedCategoryId == null ? null : suggestedCategoryId,
        "suggestedCategory": suggestedCategory == null ? null : suggestedCategory,
        "userInvestedAmount": userInvestedAmount == null ? null : userInvestedAmount,
        "folioAmount": folioAmount == null ? null : folioAmount,
        "currentFolioAmount": currentFolioAmount == null ? null : currentFolioAmount,
        "appSwitchEnable": appSwitchEnable == null ? null : appSwitchEnable,
    };
}
