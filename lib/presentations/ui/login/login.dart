import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gajiku/blocs/auth/auth_bloc.dart';
import 'package:gajiku/blocs/auth/auth_event.dart';
import 'package:gajiku/blocs/auth/auth_state.dart';

class Login extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<Login> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  AuthBloc? authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Center(
        child: Container(
          width: double.infinity,
          height: 100.0,
          child: Image.asset('assets/images/budget.png'),
        )
    );

    final msg = BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is LoginErrorState) {
          return Text(state.message);
        } else if (state is LoginLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      },
    );

    final username = TextField(
      controller: _username,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          filled: true,
          fillColor: Color(0xFFF2F3F5),
          hintStyle: TextStyle(
              color: Color(0xFF666666)
          ),
          hintText: 'Username',
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(0))
      ),
    );

    final password = TextField(
      controller: _password,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          filled: true,
          fillColor: Color(0xFFF2F3F5),
          hintStyle: TextStyle(
              color: Color(0xFF6666666)
          ),
          hintText: "Password",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(0))
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(13.0),
          minimumSize: Size(0, 0),
          elevation: 0,
        ),
        child: Text("Login", style: TextStyle(fontSize: 20.0)),
        onPressed: () {
          authBloc?.add(LoginButtonPressed(
              username: _username.text,
              password: _password.text
          ));
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ClientLoginSuccessState) {
            Navigator.pushNamed(context, '/client');
          } else if (state is AdminLoginSuccessState) {
            Navigator.pushNamed(context, '/admin');
          }
        },
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: [
              logo,
              SizedBox(height: 30.0),
              msg,
              SizedBox(height: 48.0),
              username,
              SizedBox(height: 20.0),
              password,
              SizedBox(height: 24.0),
              loginButton
            ],
          ),
        ),
      ),
    );
  }
}