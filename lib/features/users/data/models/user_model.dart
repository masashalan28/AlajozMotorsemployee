import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final String? avatar;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.avatar,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      avatar: json['avatar'],
      isActive: json['is_active'] ?? json['isActive'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'avatar': avatar,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? role,
    String? avatar,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        role,
        avatar,
        isActive,
        createdAt,
        updatedAt,
      ];
}
