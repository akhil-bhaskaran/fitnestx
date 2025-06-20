import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

ValueNotifier<AuthServices> authServices = ValueNotifier(AuthServices());

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? get currentUser => auth.currentUser;
  Stream<User?> get authStateChanges => auth.authStateChanges();

  Future<UserCredential> signin({
    required String email,
    required String pass,
  }) async {
    return await auth.signInWithEmailAndPassword(email: email, password: pass);
  }

  Future<UserCredential> signup({
    required String email,
    required String pass,
  }) async {
    return await auth.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );
  }

  Future<void> signout() async {
    await auth.signOut();
  }

  Future<void> forogtPass({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUsername({required String newusername}) async {
    await currentUser!.updateDisplayName(newusername);
  }

  Future<void> deleteAccount({
    required String email,
    required String pass,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: pass,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await auth.signOut();
  }

  Future<void> resetPassword({
    required String email,
    required String pass,
    required String newpass,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: pass,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newpass);
  }
}
