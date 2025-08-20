import 'dart:convert';

class StudentModel {
  int currentPage;
  List<Datum> data;
  String? firstPageUrl;
  int? from;
  int lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String path;
  int perPage;
  String? prevPageUrl;
  int? to;
  int total;

  StudentModel({
    required this.currentPage,
    required this.data,
    this.firstPageUrl,
    this.from,
    required this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    this.to,
    required this.total,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      currentPage: json["current_page"] ?? 1,
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      firstPageUrl: json["first_page_url"],
      from: json["from"],
      lastPage: json["last_page"] ?? 1,
      lastPageUrl: json["last_page_url"],
      links: json["links"] == null
          ? []
          : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      nextPageUrl: json["next_page_url"],
      path: json["path"] ?? '',
      perPage: json["per_page"] ?? 0,
      prevPageUrl: json["prev_page_url"],
      to: json["to"],
      total: json["total"] ?? 0,
    );
  }

  static StudentModel fromJsonString(String str) =>
      StudentModel.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  int id;
  String? khmerName;
  String? latinName;
  String? gender;
  String? dob;
  String? address;
  String? tel;
  String? createdAt;
  String? updatedAt;

  Datum({
    required this.id,
    this.khmerName,
    this.latinName,
    this.gender,
    this.dob,
    this.address,
    this.tel,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"] ?? 0,
      khmerName: json["khmer_name"],
      latinName: json["latin_name"],
      gender: json["gender"],
      dob: json["dob"],
      address: json["address"],
      tel: json["tel"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  static Datum fromJsonString(String str) =>
      Datum.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
    "id": id,
    "khmer_name": khmerName,
    "latin_name": latinName,
    "gender": gender,
    "dob": dob,
    "address": address,
    "tel": tel,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json["url"],
      label: json["label"],
      active: json["active"],
    );
  }

  static Link fromJsonString(String str) =>
      Link.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}