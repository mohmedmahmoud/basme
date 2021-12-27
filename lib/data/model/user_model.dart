// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<User> usersFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.phoneId,
    this.id,
    this.password,
    this.name,
    this.phone,
    this.role,
    this.idAgency,
    this.createAt,
    this.updateAt,
    this.idSuperUser,
    this.timeWorking,
    this.latitudeAgency,
    this.longitudeAgency,
    this.nameAgency,
  });
  String? id;
  String? phoneId;
  String? password;
  String? name;
  String? phone;
  String? role;
  String? idAgency;
  String? idSuperUser;
  DateTime? createAt;
  DateTime? updateAt;
  int? timeWorking;
  double? longitudeAgency;
  double? latitudeAgency;
  String? nameAgency;

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return User();
    }
    return User(
        timeWorking: json['timeWorking'],
        id: json['id'],
        phoneId: json['phoneId'],
        password: json['password'],
        name: json['name'],
        phone: json['phone'],
        role: json['role'],
        idAgency: json['idAgency'],
        idSuperUser: json['idSuperUser'],
        createAt: json['createAt'] == null ? null : json['createAt'].toDate(),
        updateAt: json['updateAt'] == null ? null : json['updateAt'].toDate(),
        longitudeAgency: json['longitudeAgency'],
        latitudeAgency: json['latitudeAgency'],
        nameAgency: json['nameAgency']);
  }

  factory User.fromJsonForLocalStroge(Map<String, dynamic>? json) {
    if (json == null) {
      return User();
    }
    return User(
      timeWorking: json['timeWorking'],
      id: json['id'],
      phoneId: json['phoneId'],
      password: json['password'],
      name: json['name'],
      phone: json['phone'],
      role: json['role'],
      idAgency: json['idAgency'],
      idSuperUser: json['idSuperUser'],
      createAt:
          json['createAt'] == null ? null : DateTime.tryParse(json['createAt']),
      updateAt:
          json['updateAt'] == null ? null : DateTime.tryParse(json['updateAt']),
      latitudeAgency: json['latitudeAgency'],
      longitudeAgency: json['longitudeAgency'],
      nameAgency: json['nameAgency'],
    );
  }

  Map<String, dynamic> toJson() => {
        "timeWorking": timeWorking,
        "phoneId": phoneId,
        "password": password,
        "name": name,
        "phone": phone,
        "role": role,
        'id': id,
        'idAgency': idAgency,
        'idSuperUser': idSuperUser,
        'createAt': createAt,
        'updateAt': Timestamp.fromDate(updateAt ?? DateTime.now()),
        'longitudeAgency': longitudeAgency,
        'latitudeAgency': latitudeAgency,
        'nameAgency': nameAgency,
      };
  Map<String, dynamic> toJsonForLocalStroge() => {
        'timeWorking': timeWorking,
        "phoneId": phoneId,
        "password": password,
        "name": name,
        "phone": phone,
        "role": role,
        'id': id,
        'idAgency': idAgency,
        'idSuperUser': idSuperUser,
        'createAt': createAt == null ? null : createAt.toString(),
        'updateAt': updateAt == null ? null : updateAt.toString(),
        'longitudeAgency': longitudeAgency,
        'latitudeAgency': latitudeAgency,
        'nameAgency': nameAgency,
      };
}
