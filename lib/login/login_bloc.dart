import 'package:bloc_pattern/api_service.dart';
import 'package:bloc_pattern/login/form/form_submission_status.dart';
import 'package:bloc_pattern/login/login.dart';
import 'package:bloc_pattern/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppRepo authRepo;

  LoginBloc({this.authRepo}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated
    if (event is LoginUsernameChange) {
      yield state.copyWith(username: event.username);

      // Password updated
    } else if (event is LoginPassChange) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: SubmittingFormStatus());

      try {
        await authRepo.loginIn();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
