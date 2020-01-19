import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_sample_meetup_app/blocs/auth/auth_repository.dart';
import 'package:flutter_sample_meetup_app/models/current_user.dart';

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  @override
  Future<CurrentUser> getCurrentUser() async {
    final currentUser = await _firebaseAuth.currentUser();
    return CurrentUser(
      id: currentUser.uid,
      name: currentUser.displayName ?? "",
      photoUrl: currentUser.photoUrl ?? "",
      isAnonymous: currentUser.isAnonymous,
      createAt: DateTime.fromMillisecondsSinceEpoch(currentUser.metadata.creationTimestamp),
      updateAt: DateTime.fromMillisecondsSinceEpoch(currentUser.metadata.lastSignInTimestamp)
    );
  }

  @override
  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  @override
  Future<void> signOut() {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut()
    ]);
  }
}
