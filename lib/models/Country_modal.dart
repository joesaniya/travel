// To parse this JSON data, do
//
//     final countryModal = countryModalFromJson(jsonString);

import 'dart:convert';

CountryModal? countryModalFromJson(String str) =>
    CountryModal.fromJson(json.decode(str));

String countryModalToJson(CountryModal? data) => json.encode(data!.toJson());

class CountryModal {
  CountryModal({
    this.countries,
    this.destinations,
  });

  List<Country?>? countries;
  List<Destination?>? destinations;

  factory CountryModal.fromJson(Map<String, dynamic> json) => CountryModal(
        countries: json["countries"] == null
            ? []
            : List<Country?>.from(
                json["countries"]!.map((x) => Country.fromJson(x))),
        destinations: json["destinations"] == null
            ? []
            : List<Destination?>.from(
                json["destinations"]!.map((x) => Destination.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countries": countries == null
            ? []
            : List<dynamic>.from(countries!.map((x) => x!.toJson())),
        "destinations": destinations == null
            ? []
            : List<dynamic>.from(destinations!.map((x) => x!.toJson())),
      };
}

class Country {
  Country({
    this.id,
    this.countryName,
    this.isocode,
    this.phonecode,
    this.flag,
    this.currencySymbol,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isDeleted,
  });

  String? id;
  String? countryName;
  String? isocode;
  String? phonecode;
  String? flag;
  String? currencySymbol;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? isDeleted;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["_id"],
        countryName: json["countryName"],
        isocode: json["isocode"],
        phonecode: json["phonecode"],
        flag: json["flag"],
        currencySymbol: json["currencySymbol"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "countryName": countryName,
        "isocode": isocode,
        "phonecode": phonecode,
        "flag": flag,
        "currencySymbol": currencySymbol,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "isDeleted": isDeleted,
      };
}

class Destination {
  Destination({
    this.id,
    this.country,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isDeleted,
    this.image,
  });

  String? id;
  String? country;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? isDeleted;
  String? image;

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        id: json["_id"],
        country: json["country"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        isDeleted: json["isDeleted"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "country": country,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "isDeleted": isDeleted,
        "image": image,
      };
}
