import 'package:equatable/equatable.dart';
import '../models/api_response_model.dart';
import '../models/user_model.dart';

abstract class UserRepo extends Equatable {
  // Authentication
  Future<ApiResponseModel<UserModel>> login({
    required String phone,
    required String password,
  });

  Future<ApiResponseModel<void>> logout({
    required String token,
  });

  // Password Management
  Future<ApiResponseModel<void>> forgetPassword({
    required String phone,
  });

  Future<ApiResponseModel<void>> verifyResetCode({
    required String phone,
    required String otp,
  });

  Future<ApiResponseModel<void>> resetPassword({
    required String phone,
    required String otp,
    required String newPassword,
  });

  // User Profile
  Future<ApiResponseModel<UserModel>> getProfile({
    required String token,
  });

  // User Status
  Future<ApiResponseModel<void>> checkIn({
    required String token,
    required String deviceId,
    required double latitude,
    required double longitude,
  });

  Future<ApiResponseModel<void>> checkOut({
    required String token,
  });

  @override
  List<Object?> get props => [];
}
