import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SignInState extends Equatable {
  SignInState([List props = const[]]) : super(props);
}

class SignInEmpty extends SignInState {
  @override
  String toString() => 'SignInState';
}

class SignInLoading extends SignInState {
  @override
  String toString() => 'SignInLoading';
}

class SignInSuccess extends SignInState {
  @override
  String toString() => 'SignInSuccess';
}

class SignInFailure extends SignInState {
  @override
  String toString() => 'SignInFailure';
}