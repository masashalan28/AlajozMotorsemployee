import 'package:equatable/equatable.dart';

class ApiResponse<T> extends Equatable {
  final bool success;
  final String? message;
  final T? data;
  final List<String>? errors;
  final int? statusCode;

  const ApiResponse({
    this.success = false,
    this.message,
    this.data,
    this.errors,
    this.statusCode,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
      errors: json['errors'] != null ? List<String>.from(json['errors']) : null,
      statusCode: json['status_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
      'errors': errors,
      'status_code': statusCode,
    };
  }

  @override
  List<Object?> get props => [success, message, data, errors, statusCode];
}

class PaginatedResponse<T> extends Equatable {
  final List<T> data;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final String? nextPageUrl;
  final String? prevPageUrl;

  const PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponse<T>(
      data: (json['data'] as List).map((item) => fromJsonT(item)).toList(),
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 10,
      total: json['total'] ?? 0,
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
    );
  }

  bool get hasNextPage => nextPageUrl != null;
  bool get hasPrevPage => prevPageUrl != null;

  @override
  List<Object?> get props => [
        data,
        currentPage,
        lastPage,
        perPage,
        total,
        nextPageUrl,
        prevPageUrl,
      ];
}
