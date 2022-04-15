import 'package:flutter/material.dart';
import 'package:gajiku/presentations/screens/BankingDashboard.dart';
import 'package:gajiku/presentations/screens/BankingSplash.dart';
import 'package:gajiku/presentations/screens/login/login.dart';
import 'package:gajiku/presentations/screens/manager/manager.dart';
import 'package:gajiku/presentations/screens/admin/admin.dart';
import 'package:gajiku/presentations/screens/client/client.dart';


var customRoutes = <String, WidgetBuilder>{
  '/': (context) => BankingSplash(),
  '/login': (context) => Login(),
  '/manager': (context) => Manager(),
  '/admin': (context) => Admin(),
  '/client': (context) => Client(),
  '/dashboard': (context) => BankingDashboard()
};