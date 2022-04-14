import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gajiku/presentations/ui/admin/admin.dart';
import 'package:gajiku/presentations/ui/login/login.dart';
import 'package:gajiku/presentations/ui/client/client.dart';
import 'package:gajiku/presentations/ui/manager/manager.dart';

import 'blocs/auth/auth_bloc.dart';
import 'data/repositories/auth_repo.dart';
import 'data/repositories/userinfo_repo.dart';

void main() {
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
          initialRoute: '/',
          routes: {
            '/': (context) => Login(),
            '/manager': (context) => Manager(),
            '/admin': (context) => Admin(),
            '/client': (context) => Client()
          },
        )
    );
  }
}
