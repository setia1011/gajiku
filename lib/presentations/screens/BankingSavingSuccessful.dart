import 'package:gajiku/main.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:gajiku/presentations/utils/BankingColors.dart';
import 'package:gajiku/presentations/utils/BankingContants.dart';
import 'package:gajiku/presentations/utils/BankingImages.dart';
import 'package:gajiku/presentations/utils/BankingStrings.dart';
import 'package:gajiku/presentations/utils/BankingWidget.dart';

class BankingSavingSuccessful extends StatefulWidget {
  @override
  _BankingSavingSuccessfulState createState() => _BankingSavingSuccessfulState();
}

class _BankingSavingSuccessfulState extends State<BankingSavingSuccessful> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              30.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.chevron_left,
                    size: 25,
                    color: appStore.isDarkModeOn ? white : Banking_blackColor,
                  ).onTap(
                    () {
                      finish(context);
                    },
                  ),
                  16.height,
                  Text("Save\nSuccessful", style: boldTextStyle(size: 30)),
                ],
              ),
              16.height,
              Image.asset(Banking_ic_walk3, height: 250, width: width, fit: BoxFit.fill),
              8.height,
              Text(
                Banking_lbl_Successful_Detail,
                style: primaryTextStyle(color: Banking_TextColorSecondary, size: 18, fontFamily: fontRegular),
              ).center(),
              24.height,
              BankingButton(
                textContent: Banking_lbl_View_Saving,
                onPressed: () {
                  finish(context);
                  finish(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
