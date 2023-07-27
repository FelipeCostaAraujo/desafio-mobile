import './translation.dart';

class EnUs implements Translation {
  @override
  String get msgAlreadyHaveAnAccount => "Already have an account?";

  @override
  String get msgNoInternetConnection => "No internet connection";

  @override
  String get signIn => "Sign In";

  @override
  String get signUp => "Sign Up";

}