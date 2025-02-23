import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:manager/Domain/Failure/auth_failure.dart';
import 'package:manager/Domain/SignIn/sign_in_service.dart';
import 'package:manager/Domain/User/user.dart';

@LazySingleton(as: SignInService)
class SignInRepo implements SignInService {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  SignInRepo(this.firebaseAuth, this.googleSignIn);
  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleuser = await googleSignIn.signIn();
      if (googleuser == null) {
        return left(const AuthFailure.cancelledbyuser());
      }
      final googleAuthentification = await googleuser.authentication;
      final authcredential = GoogleAuthProvider.credential(
          idToken: googleAuthentification.idToken,
          accessToken: googleAuthentification.accessToken);
      return firebaseAuth
          .signInWithCredential(authcredential)
          .then((r) => right(unit));
    } on FirebaseAuthException catch (_) {
      return left(const AuthFailure.servererror());
    }
  }

  @override
  Future<void> signOut() {
    return Future.wait([googleSignIn.signOut(), firebaseAuth.signOut()]);
  }

  @override
  Future<Option<DomainUser>> getSignedInUser() async {
    User? user = firebaseAuth.currentUser;
    log(user.toString());
    if (user == null) {
      return none();
    }
    return optionOf(DomainUser(uid: user.uid, name: user.displayName ?? ''));
  }
}
