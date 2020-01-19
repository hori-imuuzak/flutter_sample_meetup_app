import 'package:equatable/equatable.dart';
import 'package:flutter_sample_meetup_app/models/current_user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState extends Equatable {
  AuthState([List props = const[]]) : super(props);
}

class AuthInProgress extends AuthState {
  @override
  String toString() => 'AuthInProgress';
}

class AuthSuccess extends AuthState {
  final CurrentUser currentUser;

  AuthSuccess(this.currentUser) : super([currentUser]);

  @override
  String toString() => 'AuthSuccess';
}

class AuthFailure extends AuthState {
  @override
  String toString() => 'AuthFailure';
}