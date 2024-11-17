import 'package:google_sign_in/google_sign_in.dart';

class AuthenticateUserResult {
  final String? jwtToken;
  final GoogleSignInAccount? googleAccount;

  AuthenticateUserResult(this.jwtToken, this.googleAccount);
}