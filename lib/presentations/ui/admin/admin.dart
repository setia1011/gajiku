import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _name = "";
  String _notif = "9";

  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString("name")!;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0.0), topRight: Radius.circular(0.0)),
          child: Text("Admin Page"),
        ),
        leading: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: IconButton(
                onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                icon: const Icon(Icons.menu, size: 32, color: Colors.white))),
        backgroundColor: Colors.indigo,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                  padding: const EdgeInsets.only(right: 15.0, top: 15.0),
                  onPressed: () {},
                  icon: const Icon(Icons.email, color: Colors.white)
              ),
              _notif == "0" ? Container() : Positioned(
                right: 13.0,
                top: 10.0,
                child: Stack(
                  children: [
                    Icon(
                        Icons.brightness_1,
                        size: 20.0,
                        color: Colors.redAccent
                    ),
                    Positioned(
                      top: 3.0,
                      right: 6.0,
                      child: Text(
                          _notif,
                          style: TextStyle(color: Colors.white, fontSize: 11.0
                          )
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
      body: Center(
        child: Text(
            "Hi " + _name + "\n(administrator)",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            )
        ),
      ),
    );
  }
}
