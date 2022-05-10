import 'package:gajiku/main.dart';
import 'package:gajiku/presentations/screens/BankingChangePasword.dart';
import 'package:gajiku/presentations/screens/GaProfileUpdate.dart';
import 'package:gajiku/presentations/utils/GaColors.dart';
import 'package:gajiku/presentations/utils/GaImages.dart';
import 'package:gajiku/presentations/utils/GaStrings.dart';
import 'package:gajiku/presentations/utils/GaWidget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class GaProfile extends StatefulWidget {
  static var tag = "/BankingMenu";

  @override
  _GaProfileState createState() => _GaProfileState();
}

class _GaProfileState extends State<GaProfile> {
  String name = "";
  String idNumber = "";

  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idNumber = prefs.getString("id_number").toString();
    });
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              16.height,
              Container(
                padding: const EdgeInsets.all(8),
                // decoration: boxDecorationWithShadow(
                //   borderRadius: BorderRadius.circular(10),
                //   backgroundColor: context.cardColor,
                // ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const CircleAvatar(backgroundImage: AssetImage(Banking_ic_user1), radius: 40),
                    10.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        5.height,
                        Text(name, style: boldTextStyle(size: 18)),
                        5.height,
                        Text(idNumber, style: primaryTextStyle(color: Banking_TextColorSecondary)),
                        5.height,
                        Text(Banking_lbl_app_Name, style: secondaryTextStyle()),
                      ],
                    ).expand()
                  ],
                ),
              ),
              16.height,
              const Text(
                  Ga_lbl_Profile,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  )
              ),
              16.height,
              Container(
                padding: const EdgeInsets.all(8),
                decoration: boxDecorationWithShadow(
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: context.cardColor,
                ),
                child: Column(
                  children: <Widget>[
                    bankingOption(Banking_ic_Setting, Ga_lbl_Update_Profile, Banking_BalanceColor).onTap(() {
                      GaProfileUpdate().launch(context);
                    }),
                    bankingOption(Banking_ic_security, Banking_lbl_Change_Password, Banking_pinkColor).onTap(() {
                      BankingChangePassword().launch(context);
                    }),
                  ],
                ),
              ),
              16.height,
              Container(
                padding: EdgeInsets.all(8),
                decoration: boxDecorationWithShadow(
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: context.cardColor,
                ),
                child: Column(
                  children: <Widget>[
                    bankingOption(Banking_ic_Logout, Banking_lbl_Logout, Banking_pinkColor).onTap(
                          () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

dialogContent(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: appStore.isDarkModeOn ? Colors.black :  Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 10.0, offset: const Offset(0.0, 10.0)),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        16.height,
        Text(Banking_lbl_Confirmation_for_logout, style: primaryTextStyle(size: 18)).onTap(() {
          finish(context);
        }).paddingOnly(top: 8, bottom: 8),
        Divider(height: 10, thickness: 1.0, color: Banking_greyColor),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Cancel", style: primaryTextStyle(size: 18)).onTap(
                  () {
                finish(context);
              },
            ).paddingRight(16),
            Container(width: 1.0, height: 40, color: Banking_greyColor).center(),
            Text("Logout", style: primaryTextStyle(size: 18, color: Banking_Primary)).onTap(
                  () {
                finish(context);
              },
            ).paddingLeft(16)
          ],
        ),
        16.height,
      ],
    ),
  );
}
