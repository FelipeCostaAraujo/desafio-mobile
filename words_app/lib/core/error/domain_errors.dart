enum DomainError {
  invalidCredentials,
  timeOut,
  serverError,
  unexpected,
  userNotFound,
  emailInUse,
  emailInvalid,
  passwordWeak,
  wordNotFound,
  accessDenied;

  String get description {
    switch (this) {
      case DomainError.emailInUse:
        return 'Email already in use';
      case DomainError.wordNotFound:
        return 'Word not found';
      case DomainError.emailInvalid:
        return 'Invalid email';
      case DomainError.passwordWeak:
        return 'Password is too weak';
      case DomainError.userNotFound:
        return 'User not found';
      case DomainError.invalidCredentials:
        return 'Invalid credentials';
      case DomainError.timeOut:
        return 'Time out';
      case DomainError.serverError:
        return 'Server error';
      default:
        return 'Unexpected error';
    }
  }
}
