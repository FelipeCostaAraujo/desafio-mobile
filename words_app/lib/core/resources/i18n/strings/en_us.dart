import './translation.dart';

class EnUs implements Translation {
  @override
  String get favorites => "Favorites";

  @override
  String get history => "History";

  @override
  String get signIn => "Sign In";

  @override
  String get signUp => "Sign Up";

  @override
  // TODO: implement words
  String get wordsList => "Word List";

  @override
  String get msgAlreadyHaveAnAccount => "Already have an account?";

  @override
  String get msgNoInternetConnection => "No internet connection";

  @override
  String get msgServerFailure => "Server failure";
}
