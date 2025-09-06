class AppConstants {

  static const String baseUrl = 'https://ajouzmotors.online/api';


  static const String userLogin = '/v1/auth/user/login';
  static const String userLogout = '/v1/auth/user/logout';
  static const String userProfile = '/v1/user/profile';
  static const String userCheckOut = '/v1/user/check-out';
  static const String userCheckIn = '/v1/user/check-in';
  static const String userForgetPassword = '/v1/auth/user/forget-password';
  static const String userVerifyReset = '/v1/auth/user/verify-reset';
  static const String userResetPassword = '/v1/auth/user/reset-password';

  
  static const String brands = '/v1/brands';
  static const String models = '/v1/models';
  static const String modelsByBrand = '/v1/brand/models';
  static const String colors = '/v1/colors';
  static const String carTypes = '/v1/types';
  static const String cars = '/v1/cars';


  static const String successMessage = 'Success';
  static const String errorMessage = 'Error occurred';


  static const String userTokenKey = 'user_token';
  static const String userPhoneKey = 'user_phone';
  static const String isLoggedInKey = 'is_logged_in';
}
