import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String? token;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? salary;
  final DateTime? hiredDate;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.token,
    this.createdAt,
    this.updatedAt,
    this.salary,
    this.hiredDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      token: json['token'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      salary: json['salary'],
      hiredDate: json['hired_date'] != null
          ? DateTime.parse(json['hired_date'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'token': token,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'salary': salary,
      'hired_date': hiredDate?.toIso8601String(),
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? token,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? salary,
    DateTime? hiredDate,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      token: token ?? this.token,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      salary: salary ?? this.salary,
      hiredDate: hiredDate ?? this.hiredDate,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, phone, email, token, createdAt, updatedAt, salary, hiredDate];
}
