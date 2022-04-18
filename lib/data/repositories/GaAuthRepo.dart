import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api/api.dart';


class GaAuthRepo {
  login(String username, String password) async {
    try {
      Map data = {"username": username, "password": password};
      String body = json.encode(data);
      var res = await http.post(
          Uri.parse(BaseUrl.urlLogin),
          headers: {"Content-Type": "application/json"},
          body: body
      );

      if (res.statusCode == 500) {
        return jsonEncode({"detail": "Terjadi kesalahan"});
      } else {
        return res.body;
      }
    } on Exception catch(e) {
      return e;
    }
  }
}