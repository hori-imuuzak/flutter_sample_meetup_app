import 'package:flutter_sample_meetup_app/models/current_user.dart';

abstract class AuthRepository {
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<CurrentUser> getCurrentUser();
}