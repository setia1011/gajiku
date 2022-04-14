import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginStartEvent extends AuthEvent {}

class LoginButtonPressed extends AuthEvent {
  final String username;
  final String password;

  LoginButtonPressed({required this.username, required this.password});
}