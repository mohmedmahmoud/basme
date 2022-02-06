import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Basme/model_view_controller/data/model/user_model.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('user');

  Future<DocumentSnapshot<dynamic>> checkUserExist({required String id}) async {
    return _userCollectionRef.doc(id).get();
  }

  Future<QuerySnapshot<dynamic>> signIn({
    required String phone,
    required String password,
  }) {
    return _userCollectionRef
        .where(
          'phone',
          isEqualTo: phone,
        )
        .where(
          'password',
          isEqualTo: password,
        )
        .limit(1)
        .get();
  }

//  add user in admin
  Future addUser({required Map<String, dynamic> user}) =>
      _userCollectionRef.add(user).then((value) {
        value.update({'id': value.id}).catchError((e) => print(e));
        return value.id;
      }).catchError((e) {
        print('----------------$e---------------');
      });

  Future<void> addUserToFireStore(User userModel) async {
    return await _userCollectionRef
        .doc(userModel.id)
        .update(userModel.toJson());
  }

  Future<void> updateUser({
    required User userModel,
  }) async {
    return _userCollectionRef.doc(userModel.id).update(userModel.toJson());
  }
}
