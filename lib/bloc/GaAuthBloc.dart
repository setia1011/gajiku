import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gajiku/data/repositories/GaUserInfoRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gajiku/data/repositories/GaAuthRepo.dart';
import 'GaAuthEvent.dart';
import 'GaAuthState.dart';


class GaAuthBloc extends Bloc<GaAuthEvent, GaAuthState> {
  GaAuthRepo repo;
  GaUserInfoRepo userInfoRepo;
  GaAuthBloc(this.repo, this.userInfoRepo): super(AuthInitial()) {
    on<GaAuthEvent>((event, emit) async {
      var pref = await SharedPreferences.getInstance();
      if (event is LoginStartEvent) {
        emit(LoginInitState());
      } else if (event is LoginButtonPressed) {
        emit(LoginLoadingState());
        var data = await repo.login(event.username, event.password);
        if (data['access_token'] != "") {
          // Save access token
          pref.setString("access_token", data['access_token']);
          // Get access token
          var accessToken = await pref.getString("access_token");
          // Get user information
          var userInfo = await userInfoRepo.detail(accessToken!);
          // Save user information
          pref.setString("username", userInfo['username']);
          pref.setString("email", userInfo['email']);
          pref.setString("name", userInfo['name']);
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
          emit(LoginErrorState(message: "Terjadi kesalahan"));
        }
      } else {
        emit(LoginErrorState(message: "Username dan/atau password tidak sesuai"));
      }
    });
  }
}