part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoggedIn extends UserState {
  final UserModel user;

  const UserLoggedIn({required this.user});

  @override
  List<Object?> get props => [user];
}

class UserLoggedOut extends UserState {}

class PasswordResetCodeSent extends UserState {
  final String message;

  const PasswordResetCodeSent({required this.message});

  @override
  List<Object?> get props => [message];
}

class ResetCodeVerified extends UserState {
  final String message;

  const ResetCodeVerified({required this.message});

  @override
  List<Object?> get props => [message];
}

class PasswordResetSuccess extends UserState {
  final String message;

  const PasswordResetSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CheckInSuccess extends UserState {
  final String message;

  const CheckInSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CheckOutSuccess extends UserState {
  final String message;

  const CheckOutSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProfileLoaded extends UserState {
  final UserModel user;

  const ProfileLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  final String message;

  const UserError({required this.message});

  @override
  List<Object?> get props => [message];
}
