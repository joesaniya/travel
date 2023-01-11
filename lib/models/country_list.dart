// class CountryList {
//   List<Countries>? countries;
//   List<Destinations>? destinations;

//   CountryList({this.countries, this.destinations});

//   CountryList.fromJson(Map<String, dynamic> json) {
//     if (json['countries'] != null) {
//       countries = <Countries>[];
//       json['countries'].forEach((v) {
//         countries!.add(new Countries.fromJson(v));
//       });
//     }
//     if (json['destinations'] != null) {
//       destinations = <Destinations>[];
//       json['destinations'].forEach((v) {
//         destinations!.add(new Destinations.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.countries != null) {
//       data['countries'] = this.countries!.map((v) => v.toJson()).toList();
//     }
//     if (this.destinations != null) {
//       data['destinations'] = this.destinations!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Countries {
//   String? sId;
//   String? countryName;
//   String? isocode;
//   String? phonecode;
//   String? flag;
//   String? currencySymbol;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   bool? isDeleted;

//   Countries(
//       {this.sId,
//       this.countryName,
//       this.isocode,
//       this.phonecode,
//       this.flag,
//       this.currencySymbol,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.isDeleted});

//   Countries.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     countryName = json['countryName'];
//     isocode = json['isocode'];
//     phonecode = json['phonecode'];
//     flag = json['flag'];
//     currencySymbol = json['currencySymbol'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     isDeleted = json['isDeleted'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['countryName'] = this.countryName;
//     data['isocode'] = this.isocode;
//     data['phonecode'] = this.phonecode;
//     data['flag'] = this.flag;
//     data['currencySymbol'] = this.currencySymbol;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     data['isDeleted'] = this.isDeleted;
//     return data;
//   }
// }

// class Destinations {
//   String? sId;
//   String? country;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   bool? isDeleted;
//   String? image;

//   Destinations(
//       {this.sId,
//       this.country,
//       this.name,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.isDeleted,
//       this.image});

//   Destinations.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     country = json['country'];
//     name = json['name'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     isDeleted = json['isDeleted'];
//     image = json['image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['country'] = this.country;
//     data['name'] = this.name;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     data['isDeleted'] = this.isDeleted;
//     data['image'] = this.image;
//     return data;
//   }
// }
