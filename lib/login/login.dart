abstract class LoginEvent {}

class LoginUsernameChange extends LoginEvent {
  final String username;
  LoginUsernameChange({this.username});
}

class LoginPassChange extends LoginEvent {
  final String password;
  LoginPassChange({this.password});
}

class LoginSubmitted extends LoginEvent {}
