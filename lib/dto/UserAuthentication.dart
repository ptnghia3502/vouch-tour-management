class UserAuthenticationManager {
  String? accessToken = '';
  String? refreshToken = '';
  String? role = '';
  String? id = '';
  String? email = '';

  UserAuthenticationManager(
      {required this.accessToken,
      required this.refreshToken,
      required this.role,
      required this.id,
      required this.email});
}
