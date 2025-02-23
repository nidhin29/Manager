import 'package:dartz/dartz.dart';
import 'package:manager/Domain/Failure/auth_failure.dart';
import 'package:manager/Domain/User/user.dart';

abstract class SignInService {
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<void> signOut();
  Future<Option<DomainUser>> getSignedInUser();
}
