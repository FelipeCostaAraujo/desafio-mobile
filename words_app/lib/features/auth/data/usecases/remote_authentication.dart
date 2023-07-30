import 'package:firebase_auth/firebase_auth.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/auth/domain/usecases/authentication.dart';

class RemoteAuthentication implements Authentication {
  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => null)
          .onError((error, stackTrace) async {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      });
    } on FirebaseException catch (error) {
      switch (error.code) {
        case 'user-not-found':
        case 'wrong-password':
          throw DomainError.invalidCredentials;
        default:
          throw DomainError.unexpected;
      }
    }
  }
}
