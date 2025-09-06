import 'package:equatable/equatable.dart';

class ApiResponseModel<T> extends Equatable {
  final String message;
  final T? data;
  final bool success;

  const ApiResponseModel({
    required this.message,
    this.data,
    required this.success,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJsonT,
  ) {
    return ApiResponseModel(
      message: json['message'] ?? '',
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
      success: json['message'] == 'ok' || json['success'] == true,
    );
  }

  @override
  List<Object?> get props => [message, data, success];
}

class LoginResponseModel extends Equatable {
  final String message;
  final UserDataModel? data;
  final bool success;

  const LoginResponseModel({
    required this.message,
    this.data,
    required this.success,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'] ?? '',
      data: json['data'] != null ? UserDataModel.fromJson(json['data']) : null,
      success: json['message'] == 'ok' || json['success'] == true,
    );
  }

  @override
  List<Object?> get props => [message, data, success];
}

class UserDataModel extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String token;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserDataModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.token,
    this.createdAt,
    this.updatedAt,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, phone, email, token, createdAt, updatedAt];
}
