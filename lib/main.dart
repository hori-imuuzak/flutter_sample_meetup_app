import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_meetup_app/blocs/auth/auth_bloc.dart';
import 'package:flutter_sample_meetup_app/blocs/auth/auth_event.dart';
import 'package:flutter_sample_meetup_app/blocs/auth/auth_state.dart';
import 'package:flutter_sample_meetup_app/repositories/firebase_auth_repository.dart';
import 'package:flutter_sample_meetup_app/screens/event_list_screen.dart';
import 'package:flutter_sample_meetup_app/screens/sign_in_screen.dart';

void main() {
  final authRepository = FirebaseAuthRepository();
  runApp(BlocProvider<AuthBloc>(
    builder: (context) =>
        AuthBloc(authRepository: authRepository)..dispatch(AppStarted()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return MaterialApp(
        title: 'Sample Flutter Meetup',
        theme: ThemeData(
            primaryColor: Colors.indigo[900],
            accentColor: Colors.pink[800],
            brightness: Brightness.light),
        home: BlocBuilder<AuthBloc, AuthState>(
          bloc: authBloc,
          builder: (context, state) {
            print(state.toString());
            if (state is AuthInProgress) {
              // TODO Splash
              return Center(
                child: const Text("Splash"),
              );
            }

            if (state is AuthSuccess) {
              return EventListScreen();
            }

            if (state is AuthFailure) {
              return SignInScreen();
            }

            return Container();
          },
        ));
  }
}
