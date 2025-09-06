import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repos/user_repo.dart';
import '../../data/models/user_model.dart';
import '../../../../core/services/storage_service.dart';
//import '../../data/models/api_response_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo _userRepo;

  UserCubit(this._userRepo) : super(UserInitial());

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    emit(UserLoading());

    try {
      final response = await _userRepo.login(
        phone: phone,
        password: password,
      );

      if (response.success && response.data != null) {
     
        if (response.data!.token != null) {
          await StorageService.saveToken(response.data!.token!);
        }
        await StorageService.saveUserPhone(response.data!.phone);
        emit(UserLoggedIn(user: response.data!));
      } else {
        emit(UserError(message: response.message));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> logout({
    required String token,
  }) async {
    emit(UserLoading());

    try {
      final response = await _userRepo.logout(token: token);

      if (response.success) {
    
        await StorageService.clearUserData();
        emit(UserLoggedOut());
      } else {
        emit(UserError(message: response.message));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> getProfile({
    required String token,
  }) async {
    emit(UserLoading());

    try {
      final response = await _userRepo.getProfile(token: token);

      if (response.success && response.data != null) {
        emit(ProfileLoaded(user: response.data!));
      } else {
        emit(UserError(message: response.message));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> forgetPassword({
    required String phone,
  }) async {
    emit(UserLoading());

    try {
      final response = await _userRepo.forgetPassword(phone: phone);

      if (response.success) {
        emit(PasswordResetCodeSent(message: response.message));
      } else {
        emit(UserError(message: response.message));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> verifyResetCode({
    required String phone,
    required String otp,
  }) async {
    emit(UserLoading());

    try {
      final response = await _userRepo.verifyResetCode(
        phone: phone,
        otp: otp,
      );

      if (response.success) {
        emit(ResetCodeVerified(message: response.message));
      } else {
        emit(UserError(message: response.message));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> resetPassword({
    required String phone,
    required String otp,
    required String newPassword,
  }) async {
    emit(UserLoading());

    try {
      final response = await _userRepo.resetPassword(
        phone: phone,
        otp: otp,
        newPassword: newPassword,
      );

      if (response.success) {
        emit(PasswordResetSuccess(message: response.message));
      } else {
        emit(UserError(message: response.message));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> checkIn({
    required String token,
    required String deviceId,
    required double latitude,
    required double longitude,
  }) async {
    emit(UserLoading());

    try {
      final response = await _userRepo.checkIn(
        token: token,
        deviceId: deviceId,
        latitude: latitude,
        longitude: longitude,
      );

      if (response.success) {
        emit(CheckInSuccess(message: response.message));
      } else {
        emit(UserError(message: response.message));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> checkOut({
    required String token,
  }) async {
    emit(UserLoading());

    try {
      final response = await _userRepo.checkOut(token: token);

      if (response.success) {
        emit(CheckOutSuccess(message: response.message));
      } else {
        emit(UserError(message: response.message));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  void resetState() {
    emit(UserInitial());
  }

  Future<String?> getSavedToken() async {
    return await StorageService.getToken();
  }


  Future<bool> isLoggedIn() async {
    return await StorageService.isLoggedIn();
  }
}
