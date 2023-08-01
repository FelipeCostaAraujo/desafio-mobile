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
  String get tryAgain => "Try again";

  @override
  String get wordsList => "Word List";
  @override
  String get msgAlreadyHaveAnAccount => "Already have an account?";
  @override
  String get msgNoFavoritesYet => "No favorites yet";
  @override
  String get msgNoHistoryYet => "No history yet";
  @override
  String get msgNoInternetConnection => "No internet connection";
  @override
  String get msgServerFailure => "Server failure";
}
