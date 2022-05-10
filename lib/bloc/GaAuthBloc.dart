import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gajiku/data/repositories/GaUserInfoRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gajiku/data/repositories/GaAuthRepo.dart';
import 'GaAuthEvent.dart';
import 'GaAuthState.dart';


class GaAuthBloc extends Bloc<GaAuthEvent, GaAuthState> {
  GaAuthRepo authRepo;
  GaUserInfoRepo userInfoRepo;
  GaAuthBloc(this.authRepo, this.userInfoRepo): super(AuthInitial()) {
    on<GaAuthEvent>((event, emit) async {
      var pref = await SharedPreferences.getInstance();
      try {
        if (event is LoginStartEvent) {
          emit(LoginInitState());
        } else if (event is LoginButtonPressed) {
          emit(LoginLoadingState());
          // Login
          var data = await authRepo.login(event.username, event.password);
          // Parsing data
          final Map<String, dynamic> parsed = jsonDecode(data);

          if (parsed.containsKey("access_token") && parsed['access_token'] != null) {
            // Save access token
            pref.setString("access_token", parsed['access_token']);
            // Get access token
            var accessToken = await pref.getString("access_token");
            // Get user information
            var userInfo = await userInfoRepo.detail(accessToken!);
            // Save user information
            pref.setString("username", userInfo['username']);
            pref.setString("email", userInfo['email']);
            pref.setString("name", userInfo['name']);
            pref.setInt("id_type", userInfo['id_type']);
            pref.setString("id_type_name", userInfo['ref_id_type']['id_type']);
            pref.setString("id_number", userInfo['id_number']);
            pref.setString("phone", userInfo['phone']);
            pref.setString("address", userInfo['address']);
            pref.setString("status", userInfo['status']);
            pref.setInt("group_id", userInfo['group_id']);

            if (pref.getInt("group_id") == 1) {
              emit(AdminLoginSuccessState());
            } else if (pref.getInt("group_id") == 2) {
              emit(ManagerLoginSuccessState());
            } else {
              emit(ClientLoginSuccessState());
            }
          } else {
            emit(LoginErrorState(message: parsed['detail'].toString()));
          }
        } else {
          emit(LoginErrorState(message: "Terjadi kesalahan"));
        }
      } on Exception catch(e) {
        emit(LoginErrorState(message: "Terjadi kesalahan"));
      }
    });
  }
}