import 'package:cloud_firestore/cloud_firestore.dart';

class HomeFireStore {
  final CollectionReference _attendanceCollection =
      FirebaseFirestore.instance.collection('attendance');

  Future<DocumentSnapshot<dynamic>> getAtendance(
      {required String idAttendance}) async {
    return await _attendanceCollection.doc(idAttendance).get();
  }

  // get all attendance
  Future<QuerySnapshot<dynamic>> getAttendanceAgency(
      {required String idAgency}) async {
    print('------------attendances-----------');
    return await _attendanceCollection
        // .orderBy(
        //   "clockIn",
        //   descending: true,
        // )

        .where('idAgency', isEqualTo: idAgency)
        .limit(50)
        .get();
    // .catchError((e) => print(e));
  }

//  add attendanse
  Future<DocumentReference<Object?>> addAttendance(
          {required Map<String, dynamic> attendance}) =>
      _attendanceCollection.add(attendance).then((value) {
        value.update({'id': value.id}).catchError((e) => print(e));
        return value;
      });
  // update attendanse
  Future<void> updateAttendance(
      {required String idAttendance,
      required Map<String, dynamic> attendance}) async {
    return await _attendanceCollection.doc(idAttendance).update(attendance);
  }
}
