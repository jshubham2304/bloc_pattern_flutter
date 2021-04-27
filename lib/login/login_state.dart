import 'package:bloc_pattern/login/form/form_submission_status.dart';

class LoginState {
  final String username;
  final String password;
  String get isValidUsername => username.length > 3?null:"Username is short ";
  String get isValidPassword => password.length > 6?null:"Password is too short";
  final FormSubmissionStatus formStatus;
  LoginState(
      {this.username = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()});

  LoginState copyWith(
      {String username, String password, FormSubmissionStatus formStatus}) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}
