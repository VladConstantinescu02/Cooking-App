import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn(
      scopes: ['email', 'profile'],
      serverClientId: '41870230054-sd0d7t4e9kb91cctr3kvf61p5gq03cro.apps.googleusercontent.com'
  );
});