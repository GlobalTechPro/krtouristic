import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krtouristic/model/core/user.dart' as custom_user;
import 'package:krtouristic/model/services/auth/i_auth_facade.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

extension DocumentSnapX on DocumentSnapshot<Map<String, dynamic>> {
  custom_user.User toUser() {
    return custom_user.User.fromJson(data()!)..id = id;
  }
}

@Injectable(as: IAuthFacade)
class AuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthFacade(this._firebaseAuth, this._firebaseFirestore);

  @override
  Future<custom_user.User?> getUser() async {
    try {
      final uid = _firebaseAuth.currentUser!.uid;
      final currentUser =
          await _firebaseFirestore.doc("users/$uid").snapshots().first;
      return currentUser.toUser();
    } on FirebaseAuthException {
      return null;
    }
  }

  @override
  Future<void> register(
      {required String username,
      required String email,
      required String password}) {
    return _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      return _firebaseFirestore
          .doc("User/${value.user!.uid}")
          .set({"email": email, "username": username});
    });
  }

  @override
  Future<void> signIn({required String email, required String password}) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> logOut() => _firebaseAuth.signOut();
}
