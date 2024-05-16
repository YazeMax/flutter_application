import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/resources/error.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DataState<bool>> createUser(String email, String password) async {
    try {
      // UserCredential cred = await _auth.createUserWithEmailAndPassword(
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return DataSuccess(true);
    } on FirebaseAuthException catch (e) {
      return DataFailure(
        RemoteError(code: e.code, message: e.message),
      );
    }
  }

  Future<DataState<bool>> login(String email, String password) async {
    try {
      // UserCredential cred = await _auth.signInWithEmailAndPassword(
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      return DataFailure(
        RemoteError(code: e.code, message: e.message),
      );
    }
    return DataSuccess(true);
  }

  Future<DataState<bool>> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      return DataFailure(
        RemoteError(code: e.code, message: e.message),
      );
    }
    return DataSuccess(true);
  }

  Future<DataState<bool>> resetPassord(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return DataFailure(
        RemoteError(code: e.code, message: e.message),
      );
    }
    return DataSuccess(true);
  }

  Future<DataState<bool>> confirmPassordReset(
    String code,
    String newPassword,
  ) async {
    try {
      await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
    } on FirebaseAuthException catch (e) {
      return DataFailure(
        RemoteError(code: e.code, message: e.message),
      );
    }
    return DataSuccess(true);
  }
}
