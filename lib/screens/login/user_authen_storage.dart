import 'package:admin/dto/user_authen_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthenStorage {
  static final String _keyAccessToken = 'access_token';

  // Lưu access token vào SharedPreferences
  static Future<void> setToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAccessToken, accessToken);
  }

  // Lấy access token từ SharedPreferences
  static Future<UserAuthenDTO> getUserAuthen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserAuthenDTO dto = new UserAuthenDTO();
    dto.AccessToken = prefs.getString('accessToken');
    dto.RefreshToken = prefs.getString('refreshToken');
    dto.Role = prefs.getString('role');
    dto.Id = prefs.getString('id');
    return dto;
  }
}
