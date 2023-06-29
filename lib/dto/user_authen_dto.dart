class UserAuthenDTO {
  late String? id;
  late String? role;
  late String? accessToken;
  late String? refreshToken;

  UserAuthenDTO();

  String? get Id => id;
  set Id(String? value) => id = value;

  String? get Role => role;
  set Role(String? value) => role = value;

  String? get AccessToken => accessToken;
  set AccessToken(String? value) => id = value;

  String? get RefreshToken => refreshToken;
  set RefreshToken(String? value) => refreshToken = value;
}
