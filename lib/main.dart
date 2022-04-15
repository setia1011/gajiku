import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gajiku/presentations/routes.dart';

import 'blocs/auth/auth_bloc.dart';
import 'data/repositories/auth_repo.dart';
import 'data/repositories/userinfo_repo.dart';

import 'package:gajiku/presentations/screens/BankingSplash.dart';
import 'package:gajiku/presentations/store/AppStore.dart';
import 'package:gajiku/presentations/utils/AppTheme.dart';
import 'package:gajiku/presentations/utils/BankingContants.dart';
import 'package:gajiku/presentations/utils/BankingDataGenerator.dart';
import 'package:gajiku/presentations/utils/BankingStrings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize(aLocaleLanguageList: languageList());

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  runApp(const Gajiku());
}

class Gajiku extends StatelessWidget {
  const Gajiku({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
                AuthRepo(),
                UserInfoRepository()),
          ),
        ],
        child: MaterialApp(
          title: '$Banking_lbl_app_Name${!isMobile ? ' ${platformName()}' : ''}',
          debugShowCheckedModeBanner: false,
          theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
          navigatorKey: navigatorKey,
          scrollBehavior: SBehavior(),
          supportedLocales: LanguageDataModel.languageLocales(),
          localeResolutionCallback: (locale, supportedLocales) => locale,
          initialRoute: '/',
          routes: customRoutes
        )
    );
  }
}
