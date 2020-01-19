import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SignInEvent extends Equatable {
  SignInEvent([List props = const[]]) : super(props);
}

class SignInWithGoogleOnPressed extends SignInEvent {
  @override
  String toString() => 'SignInWithGoogleOnPressed';
}

class SignInAnonymouslyOnPressed extends SignInEvent {
  @override
  String toString() => 'SignInAnonymouslyOnPressed';
}