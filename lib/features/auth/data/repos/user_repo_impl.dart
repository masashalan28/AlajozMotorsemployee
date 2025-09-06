//import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/api_service.dart';
import '../models/api_response_model.dart';
import '../models/user_model.dart';
import '../../../../constants.dart';
import 'user_repo.dart';

class UserRepoImpl implements UserRepo {
  final ApiService _apiService;
  final Dio _dio;

  UserRepoImpl(this._apiService, this._dio);

  @override
  Future<ApiResponseModel<UserModel>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final formData = FormData.fromMap({
        'phone': phone,
        'password': password,
      });

      final response = await _apiService.post(
        url: '${AppConstants.baseUrl}${AppConstants.userLogin}',
        body: formData,
        token: null,
      );

      if (response['message'] == 'Login successful' &&
          response['data'] != null) {
        final data = response['data'];
        final userInfo = data['User'];
        final token = data['access_token'];

        final userModel = UserModel(
          id: 0, 
          name: '${userInfo['first_name']} ${userInfo['last_name']}',
          phone: userInfo['phone'] ?? '',
          email: userInfo['email'] ?? '',
          token: token,
          createdAt: null,
          updatedAt: null,
        );

        return ApiResponseModel(
          message: response['message'] ?? 'Success',
          data: userModel,
          success: true,
        );
      } else {
        return ApiResponseModel(
          message: response['message'] ?? 'Login failed',
          data: null,
          success: false,
        );
      }
    } catch (e) {
      return ApiResponseModel(
        message: e.toString(),
        data: null,
        success: false,
      );
    }
  }

  @override
  Future<ApiResponseModel<void>> logout({
    required String token,
  }) async {
    try {
      final response = await _apiService.delete(
        url: '${AppConstants.baseUrl}${AppConstants.userLogout}',
        body: null,
        token: token,
      );

      return ApiResponseModel(
        message: response['message'] ?? 'Logout successful',
        data: null,
        success: true,
      );
    } catch (e) {
      return ApiResponseModel(
        message: e.toString(),
        data: null,
        success: false,
      );
    }
  }

  @override
  Future<ApiResponseModel<void>> forgetPassword({
    required String phone,
  }) async {
    try {
      final formData = FormData.fromMap({
        'phone': phone,
      });

      final response = await _apiService.post(
        url: '${AppConstants.baseUrl}${AppConstants.userForgetPassword}',
        body: formData,
        token: null,
      );

      return ApiResponseModel(
        message: response['message'] ?? 'Verification code sent',
        data: null,
        success: true,
      );
    } catch (e) {
      return ApiResponseModel(
        message: e.toString(),
        data: null,
        success: false,
      );
    }
  }

  @override
  Future<ApiResponseModel<void>> verifyResetCode({
    required String phone,
    required String otp,
  }) async {
    try {
      final formData = FormData.fromMap({
        'phone': phone,
        'otp': otp,
      });

      final response = await _apiService.post(
        url: '${AppConstants.baseUrl}${AppConstants.userVerifyReset}',
        body: formData,
        token: null,
      );

      return ApiResponseModel(
        message: response['message'] ?? 'Code verified successfully',
        data: null,
        success: true,
      );
    } catch (e) {
      return ApiResponseModel(
        message: e.toString(),
        data: null,
        success: false,
      );
    }
  }

  @override
  Future<ApiResponseModel<void>> resetPassword({
    required String phone,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final formData = FormData.fromMap({
        'phone': phone,
        'otp': otp,
        'new_password': newPassword,
      });

      final response = await _apiService.post(
        url: '${AppConstants.baseUrl}${AppConstants.userResetPassword}',
        body: formData,
        token: null,
      );

      return ApiResponseModel(
        message: response['message'] ?? 'Password reset successfully',
        data: null,
        success: true,
      );
    } catch (e) {
      return ApiResponseModel(
        message: e.toString(),
        data: null,
        success: false,
      );
    }
  }

  @override
  Future<ApiResponseModel<void>> checkIn({
    required String token,
    required String deviceId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final formData = FormData.fromMap({
        'device_id': deviceId,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      });

      final response = await _apiService.post(
        url: '${AppConstants.baseUrl}${AppConstants.userCheckIn}',
        body: formData,
        token: token,
      );

      return ApiResponseModel(
        message: response['message'] ?? 'Check-in successful',
        data: null,
        success: true,
      );
    } catch (e) {
      return ApiResponseModel(
        message: e.toString(),
        data: null,
        success: false,
      );
    }
  }

  @override
  Future<ApiResponseModel<UserModel>> getProfile({
    required String token,
  }) async {
    try {
      final response = await _apiService.get(
        url: '${AppConstants.baseUrl}${AppConstants.userProfile}',
        token: token,
        body: null,
        queryParameters: null,
      );

      if (response['message'] == 'ok' && response['data'] != null) {
        final userData = response['data'];
        final userModel = UserModel(
          id: userData['id'] ?? 0,
          name:
              '${userData['first_name'] ?? ''} ${userData['last_name'] ?? ''}',
          phone: userData['phone'] ?? '',
          email: userData['email'] ?? '',
          token: token,
          createdAt: userData['created_at'] != null
              ? DateTime.parse(userData['created_at'])
              : null,
          updatedAt: userData['updated_at'] != null
              ? DateTime.parse(userData['updated_at'])
              : null,
          salary: userData['salary'],
          hiredDate: userData['hired_date'] != null
              ? DateTime.parse(userData['hired_date'])
              : null,
        );

        return ApiResponseModel(
          message: response['message'] ?? 'Profile retrieved successfully',
          data: userModel,
          success: true,
        );
      } else {
        return ApiResponseModel(
          message: response['message'] ?? 'Failed to get profile',
          data: null,
          success: false,
        );
      }
    } catch (e) {
      return ApiResponseModel(
        message: e.toString(),
        data: null,
        success: false,
      );
    }
  }

  @override
  Future<ApiResponseModel<void>> checkOut({
    required String token,
  }) async {
    try {
      final response = await _apiService.get(
        url: '${AppConstants.baseUrl}${AppConstants.userCheckOut}',
        token: token,
        body: null,
        queryParameters: null,
      );

      return ApiResponseModel(
        message: response['message'] ?? 'Check-out successful',
        data: null,
        success: true,
      );
    } catch (e) {
      return ApiResponseModel(
        message: e.toString(),
        data: null,
        success: false,
      );
    }
  }

  @override
  List<Object?> get props => [_apiService, _dio];

  @override
  bool get stringify => true;
}
