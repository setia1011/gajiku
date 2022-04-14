import 'package:flutter/material.dart';
import 'package:gajiku/presentations/ui/login/login.dart';
import 'package:gajiku/presentations/ui/manager/manager.dart';
import 'package:gajiku/presentations/ui/admin/admin.dart';
import 'package:gajiku/presentations/ui/client/client.dart';


var customRoutes = <String, WidgetBuilder>{
  '/': (context) => Login(),
  '/manager': (context) => Manager(),
  '/admin': (context) => Admin(),
  '/client': (context) => Client()
};