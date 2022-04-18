import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gajiku/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:gajiku/presentations/screens/GaSignUp.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:gajiku/presentations/screens/BankingDashboard.dart';
import 'package:gajiku/presentations/screens/BankingForgotPassword.dart';
import 'package:gajiku/presentations/utils/BankingColors.dart';
import 'package:gajiku/presentations/utils/BankingStrings.dart';
import 'package:gajiku/presentations/utils/BankingWidget.dart';

import 'package:gajiku/bloc/GaAuthBloc.dart';
import 'package:gajiku/bloc/GaAuthEvent.dart';
import 'package:gajiku/bloc/GaAuthState.dart';

class GaAktivasi extends StatefulWidget {
  static var tag = "/BankingSignIn";

  @override
  _GaAktivasiState createState() => _GaAktivasiState();
}

class _GaAktivasiState extends State<GaAktivasi> {
  TextEditingController _acticode = TextEditingController();

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
          print(state);
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
              const SizedBox(height: 100.0),
              Text("Aktivasi", style: boldTextStyle(size: 30)),
              16.height,
              TextField(
                inputFormatters: [
                  MaskTextInputFormatter(
                    mask: '#-#-#-#-#-#',
                    filter: { "#": RegExp(r'[0-9]') },
                    type: MaskAutoCompletionType.lazy,
                  )
                ],
                decoration: const InputDecoration(
                  hintText: '0-0-0-0-0-0',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      //  when the TextFormField in unfocused
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      //  when the TextFormField in focused
                    ) ,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45)
                    )
                ),
                style: TextStyle(fontSize: 30.0),
              ),
              16.height,
              BankingButton(
                textContent: "Kirim",
                onPressed: () {
                },
              ),
              16.height,
              Column(
                children: [
                  TextButton(
                      onPressed: () {
                        GaSignUp().launch(context);
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.topLeft),
                      child: Text(
                        Banking_lbl_Have_Account_Login,
                        style: primaryTextStyle(size: 16, color: Banking_blueColor),
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
