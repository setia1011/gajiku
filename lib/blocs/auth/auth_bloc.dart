import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gajiku/data/repositories/userinfo_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gajiku/data/repositories/auth_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepo repo;
  UserInfoRepository userInfoRepo;
  AuthBloc(this.repo, this.userInfoRepo): super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
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