import 'package:google_sign_in/google_sign_in.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_account.g.dart';

@JsonSerializable()
class UserAccount {
  final String displayName;
  final String email;
  final String id;
  final String token;
  final String serverAuthCode;
  final bool isAuthenticated;

  UserAccount({
    this.displayName = '',
    this.email = '',
    this.id = '',
    this.serverAuthCode = '',
    this.isAuthenticated = false,
    this.token = ''
  });

  factory UserAccount.fromGoogleAccount(GoogleSignInAccount account, String token) {
    return UserAccount(
      displayName: account.displayName ?? '',
      email: account.email,
      id: account.id,
      serverAuthCode: account.serverAuthCode ?? '',
      isAuthenticated: true,
      token: token
    );
  }

  static UserAccount defaultAccount() {
    return UserAccount(
      displayName: '',
      email: '',
      id: '',
      serverAuthCode: '',
      isAuthenticated: false,
      token: ''
    );
  }

  factory UserAccount.fromJson(Map<String, dynamic> json) =>
      _$UserAccountFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountToJson(this);
}