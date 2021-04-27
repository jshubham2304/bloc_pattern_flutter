import 'package:bloc_pattern/api_service.dart';
import 'package:bloc_pattern/login/form/form_submission_status.dart';
import 'package:bloc_pattern/login/login.dart';
import 'package:bloc_pattern/login/login_bloc.dart';
import 'package:bloc_pattern/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter basic calculator',
      home: RepositoryProvider(
        create: (context) => AppRepo(),
        child: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginBloc(
            authRepo: context.read<AppRepo>(),
          ),
          child: _loginForm(),
        ),
      ),
    );
  }

  _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formState = state.formStatus;
          if (formState is SubmissionFailed) {
            print("Auth failed:" + formState.exception.toString());
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _userFormField(),
                _passowrdFormField(),
                _logInButton()
              ],
            ),
          ),
        ));
  }

  _userFormField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        validator: (value) => state.isValidUsername,
        onChanged: (value) =>
            context.read<LoginBloc>().add(LoginUsernameChange(username: value)),
        decoration:
            InputDecoration(icon: Icon(Icons.person), hintText: 'Username'),
      );
    });
  }

  _passowrdFormField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        validator: (value) => state.isValidPassword,
        onChanged: (value) =>
            context.read<LoginBloc>().add(LoginPassChange(password: value)),
        decoration:
            InputDecoration(icon: Icon(Icons.security), hintText: 'Password'),
      );
    });
  }

  _logInButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is SubmittingFormStatus
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
              child: Text('LogIn'));
    });
  }
}
