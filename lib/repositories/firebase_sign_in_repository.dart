import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sample_meetup_app/blocs/sign_in/sign_in_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseSignInRepository extends SignInRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseSignInRepository(
      {FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : this._firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        this._googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<Function> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
    );
    await _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<Function> signInAnonymously() async {
    await _firebaseAuth.signInAnonymously();
  }
}
