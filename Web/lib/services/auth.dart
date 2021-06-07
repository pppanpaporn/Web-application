import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:web_application/services/config.dart';
class Auth {
  
  static Future<String> login(String username ,String password) async {
    String body = 'grant_type=&username='+username+'&password='+password;
    var res = await http.post(
        Uri.http(Config.host, 'login'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Access-Control-Allow-Origin': '*'
        },
        body: body
    );
    if (res.statusCode==400) return "error";
    else{
      var js = jsonDecode(utf8.decode(res.bodyBytes));
      return js["token"].toString();
    }
  }
  static Future<bool> logout(String token) async{
    var res = await http.post(
        Uri.http(Config.host, 'logout'),
        headers: {'Authorization': 'Bearer $token'}
    );
    if(res.statusCode==200)
      return true;
    else return false;
  }
  static Future<bool> checkuser(String username) async{
    Map data = {
      "username": username
    };
    var body = json.encode(data);
    var res = await http.post(
        Uri.http(Config.host, 'checkusername'),
        body: body
    );
    var js = jsonDecode(utf8.decode(res.bodyBytes));
    if(js["available"]=="No")
      return true;
    else
      return false;

  }
  static Future<bool> signup(String username ,String password,String firstname,String lastname) async {
    Map data = {
      "username": username, "password": password, "firstname": firstname,"lastname": lastname
    };
    var body = json.encode(data);
    var res = await http.post(
        Uri.http(Config.host, 'createuser'),
        headers: {'Content-Type': 'application/json'},
        body: body
    );
    var js = jsonDecode(utf8.decode(res.bodyBytes));
    if(js["status"]=="complete") return true;
    else{
      return false;
    }
  }

  static Future<void> editUsername(String username) async {
    GetStorage box = GetStorage();
    var token = await box.read('token');
    Map data = {
      "username": username
    };
    var body = json.encode(data);
    var res = await http.put(
        Uri.http(Config.host, 'edit_username'),
        headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'},
        body: body
    );
    return;
  }

  static Future<dynamic> profile() async {
    GetStorage box = GetStorage();
    var token = await box.read('token');
    var res = await http.get(
      Uri.http(Config.host, 'profile'),
      headers: {'Authorization': 'Bearer $token'},
    );
    var js = jsonDecode(utf8.decode(res.bodyBytes));
    return js;
  }
}

