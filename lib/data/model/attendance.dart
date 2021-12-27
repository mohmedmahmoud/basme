// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Attendance userFromJson(String str) => Attendance.fromJson(json.decode(str));

String userToJson(Attendance data) => json.encode(data.toJson());

class Attendance {
  Attendance({
    this.clockIn,
    this.id,
    this.clockOut,
    this.duration,
    this.extraHours,
    this.positionClockOut,
    this.positionClockIn,
    this.status,
    this.idUser,
    this.idAgency,
    this.nameUser,
    this.phoneUser,
  });
  String? id;
  DateTime? clockIn;
  DateTime? clockOut;
  String? duration;
  String? extraHours;
  GeoPoint? positionClockOut;
  GeoPoint? positionClockIn;
  String? idUser;
  bool? status;
  String? idAgency;
  String? nameUser;
  String? phoneUser;

  factory Attendance.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Attendance();
    }
    return Attendance(
        id: json['id'],
        clockIn: json['clockIn'] == null ? null : json['clockIn'].toDate(),
        clockOut: json['clockOut'] == null ? null : json['clockIn'].toDate(),
        duration: json['duration'],
        extraHours: json['extraHours'],
        idUser: json['idUser'],
        positionClockIn: json['positionClockIn'],
        positionClockOut: json['positionClockOut'],
        status: json['status'],
        idAgency: json['idAgency'],
        nameUser: json['nameUser'],
        phoneUser: json['phoneUser']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'clockIn': clockIn,
        'clockOut': clockOut,
        'duration': duration,
        'extraHours': extraHours,
        'positionClockOut': positionClockOut,
        'positionClockIn': positionClockIn,
        'idUser': idUser,
        'status': status,
        'idAgency': idAgency,
        'nameUser': nameUser,
        'phoneUser': phoneUser,
      };
}
