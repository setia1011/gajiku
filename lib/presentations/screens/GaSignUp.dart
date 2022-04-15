import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gajiku/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:gajiku/presentations/screens/BankingDashboard.dart';
import 'package:gajiku/presentations/screens/BankingForgotPassword.dart';
import 'package:gajiku/presentations/utils/BankingColors.dart';
import 'package:gajiku/presentations/utils/BankingStrings.dart';
import 'package:gajiku/presentations/utils/BankingWidget.dart';

import 'package:gajiku/bloc/GaAuthBloc.dart';
import 'package:gajiku/bloc/GaAuthEvent.dart';
import 'package:gajiku/bloc/GaAuthState.dart';

class GaSignUp extends StatefulWidget {
  static var tag = "/BankingSignIn";

  @override
  _GaSignUpState createState() => _GaSignUpState();
}

class _GaSignUpState extends State<GaSignUp> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  GaAuthBloc? authBloc;

  @override
  void initState() {
    setStatusBarColor(appStore.isDarkModeOn ? black : white);
    authBloc = BlocProvider.of<GaAuthBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    //setStatusBarColor(Banking_palColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Text(
        Banking_lbl_app_Name.toUpperCase(),
        textAlign: TextAlign.center,
        style: primaryTextStyle(size: 16, color: Banking_TextColorSecondary),
      ).paddingBottom(16),
      body: BlocListener<GaAuthBloc, GaAuthState>(
        listener: (context, state) {
          if (state is ClientLoginSuccessState) {
            Navigator.pushNamed(context, '/client');
          } else if (state is AdminLoginSuccessState) {
            Navigator.pushNamed(context, '/dashboard');
          } else if (state is ManagerLoginSuccessState) {
            Navigator.pushNamed(context, '/manager');
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 100.0),
              Text("Daftar", style: boldTextStyle(size: 30)),
              16.height,
              EditText(text: "Email", isPassword: false),
              Divider(thickness: 1, color: Colors.black45),
              EditText(text: "Name", isPassword: false),
              Divider(thickness: 1, color: Colors.black45),
              EditText(mController: _username, text: "Username", isPassword: false),
              Divider(thickness: 1, color: Colors.black45),
              EditText(mController: _password, text: "Password", isPassword: true, isSecure: true),
              Divider(thickness: 1, color: Colors.black45),
              TextField(
                obscureText: true,
                // keyboardType: TextInputType.visiblePassword,
                controller: _username,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                  ),
                  hintText: "Email"
                ),
              ),
              20.height,
              BankingButton(
                textContent: "Sign Up",
                onPressed: () {

                },
              ),
              16.height,
              Column(
                children: [
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.topLeft),
                      child: Text(
                        Banking_lbl_Login_with_FaceID,
                        style: primaryTextStyle(size: 16, color: Banking_blueColor),
                      )
                  ),
                  16.height,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
