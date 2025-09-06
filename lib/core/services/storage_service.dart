
class StorageService {
  static String? _token;
  static String? _userPhone;
  static bool _isLoggedIn = false;


  static Future<void> saveToken(String token) async {
    _token = token;
    _isLoggedIn = true;
  }


  static Future<String?> getToken() async {
    return _token;
  }


  static Future<void> saveUserPhone(String phone) async {
    _userPhone = phone;
  }

 
  static Future<String?> getUserPhone() async {
    return _userPhone;
  }


  static Future<bool> isLoggedIn() async {
    return _isLoggedIn;
  }


  static Future<void> clearUserData() async {
    _token = null;
    _userPhone = null;
    _isLoggedIn = false;
  }
}
