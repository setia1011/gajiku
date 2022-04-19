import 'package:flutter/material.dart';
import 'package:gajiku/presentations/screens/BankingSplash.dart';
import 'package:gajiku/presentations/screens/GaAktivasi.dart';
import 'package:gajiku/presentations/screens/GaHome.dart';
import 'package:gajiku/presentations/screens/GaSignIn.dart';
import 'package:gajiku/presentations/screens/GaSignUp.dart';
import 'package:gajiku/presentations/screens/GaManager.dart';
import 'package:gajiku/presentations/screens/GaAdmin.dart';
import 'package:gajiku/presentations/screens/GaClient.dart';


var customRoutes = <String, WidgetBuilder>{
  '/': (context) => BankingSplash(),
  '/manager': (context) => GaManager(),
  '/admin': (context) => GaAdmin(),
  '/client': (context) => GaClient(),
  '/dashboard': (context) => GaHome(),
  '/daftar': (context) => GaSignUp(),
  '/login': (context) => GaSignIn(),
  '/aktivasi': (context) => GaAktivasi()
};