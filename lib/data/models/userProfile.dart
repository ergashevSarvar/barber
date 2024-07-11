// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  int id;
  String username;
  String userEmail;
  String firstname;
  String lastname;
  String email;
  dynamic telegramPhoneNumber;
  dynamic telegramUserId;
  dynamic pnfl;
  dynamic address;
  dynamic keyword;
  dynamic birthdate;
  DateTime instime;
  DateTime updtime;
  dynamic insuser;
  dynamic upduser;
  dynamic userProfilePhoto;
  int user;
  dynamic userRole;
  dynamic appMode;
  int lang;
  dynamic gender;
  dynamic country;
  dynamic region;
  dynamic district;
  dynamic status;
  List<dynamic> disability;
  List<dynamic> speakLang;
  List<dynamic> phone;

  UserProfile({
    required this.id,
    required this.username,
    required this.userEmail,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.telegramPhoneNumber,
    required this.telegramUserId,
    required this.pnfl,
    required this.address,
    required this.keyword,
    required this.birthdate,
    required this.instime,
    required this.updtime,
    required this.insuser,
    required this.upduser,
    required this.userProfilePhoto,
    required this.user,
    required this.userRole,
    required this.appMode,
    required this.lang,
    required this.gender,
    required this.country,
    required this.region,
    required this.district,
    required this.status,
    required this.disability,
    required this.speakLang,
    required this.phone,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"],
    username: json["username"],
    userEmail: json["user_email"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    telegramPhoneNumber: json["telegram_phone_number"],
    telegramUserId: json["telegram_user_id"],
    pnfl: json["pnfl"],
    address: json["address"],
    keyword: json["keyword"],
    birthdate: json["birthdate"],
    instime: DateTime.parse(json["instime"]),
    updtime: DateTime.parse(json["updtime"]),
    insuser: json["insuser"],
    upduser: json["upduser"],
    userProfilePhoto: json["user_profile_photo"],
    user: json["user"],
    userRole: json["user_role"],
    appMode: json["app_mode"],
    lang: json["lang"],
    gender: json["gender"],
    country: json["country"],
    region: json["region"],
    district: json["district"],
    status: json["status"],
    disability: List<dynamic>.from(json["disability"].map((x) => x)),
    speakLang: List<dynamic>.from(json["speak_lang"].map((x) => x)),
    phone: List<dynamic>.from(json["phone"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "user_email": userEmail,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "telegram_phone_number": telegramPhoneNumber,
    "telegram_user_id": telegramUserId,
    "pnfl": pnfl,
    "address": address,
    "keyword": keyword,
    "birthdate": birthdate,
    "instime": instime.toIso8601String(),
    "updtime": updtime.toIso8601String(),
    "insuser": insuser,
    "upduser": upduser,
    "user_profile_photo": userProfilePhoto,
    "user": user,
    "user_role": userRole,
    "app_mode": appMode,
    "lang": lang,
    "gender": gender,
    "country": country,
    "region": region,
    "district": district,
    "status": status,
    "disability": List<dynamic>.from(disability.map((x) => x)),
    "speak_lang": List<dynamic>.from(speakLang.map((x) => x)),
    "phone": List<dynamic>.from(phone.map((x) => x)),
  };
}
