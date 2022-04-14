import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginInitState extends AuthState {}

class LoginLoadingState extends AuthState {}

class ClientLoginSuccessState extends AuthState {}

class AdminLoginSuccessState extends AuthState {}

class ManagerLoginSuccessState extends AuthState {}

class SuperLoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {
  final String message;
  LoginErrorState({required this.message});
}