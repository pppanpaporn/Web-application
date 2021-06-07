import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_application/services/auth.dart';
import 'package:web_application/views/profile_widget.dart';
import 'package:web_application/views/register_complete.dart';

import 'image_profile.dart';



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  Image? image;
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  RegExp digitValidator = RegExp(r"^[a-zA-Z0-9.]{1,12}$");
  String? _usernameErrorText,_passwordErrorText;
  bool _showerrorPassword = false;


  int start =0;
  int? found = null;
  String pattern = "ABCDEFGHIJKLMNOPQRSTUVWXYZ012134567890";
  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _lastname.dispose();
    _firstname.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(213, 251, 252, 1),
                Color.fromRGBO(248, 222, 156, 1)
              ],
            )
        ),
        child: Center(
          child:
          Container(
            width: 400, height: 800,
            child: Card(
              child: (Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Text('Register', style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),),
                  ),
                  ImageProfile(),
                  topic('Username'),
                  dataTopic(data: 'Enter username',
                      control: _username,
                      call_function: (String str) async {
                        // 1
                        var res = await Auth.checkuser(str);
                        setState(() {
                          if(res){
                            _usernameErrorText = "This username already exists in the system.";
                          }
                          else if(!digitValidator.hasMatch(str) && str.isNotEmpty){
                            _usernameErrorText = "Can't use this name";
                          }
                          else {
                            _usernameErrorText = null;
                          }
                        });
                        },
                    detail_errorText: _usernameErrorText,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text('* Username get A-Z, a-z, 0-9, maximum length 12 characters.',style: TextStyle(fontSize: 12,color: Color(0xFFF55317))),
                  ),
                  topic('Password'),
                  dataTopic(data: 'Enter password',
                      control: _password,
                      call_function: checkPattern,
                    detail_errorText: _passwordErrorText
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,bottom: 10),
                    child: Container(
                      child: Text(
                          '* Password must not be less than 6 characters long, must not be a sequence of letters or numbers.',
                          style: TextStyle(fontSize: 12,color: Color(0xFFF55317))
                      ),
                    ),
                  ),
                  topic('Firstname'),
                  dataTopic(data: 'Enter firstname', control: _firstname),
                  topic('Lastname'),
                  dataTopic(data: 'Enter lastname', control: _lastname),
                  if (check())
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 155, vertical: 24),
                          color: Color(0xFFF55317),
                          onPressed: () async {
                            bool respond = await Auth.signup(
                                _username.text, _password.text, _firstname.text,
                                _lastname.text);
                            if (respond) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterComplete()));
                            }
                          },
                          child: Text('REGISTER',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                ],
              )
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool check() {
    return true;
  }

  Padding topic(String detail_topic) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(detail_topic, style: TextStyle(fontSize: 18,),),
        ],
      ),
    );
  }


  Padding dataTopic(
      {required String data, required var control, var call_function, var detail_errorText}) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextField(
        onChanged: call_function,
        controller: control,
        style: TextStyle(color: Color(0xFFF55317)),
        decoration: InputDecoration(
          errorText: detail_errorText,
          border: OutlineInputBorder(),
          hintText: data,
        ),
      ),
    );
  }

  // Widget imageProfile(){
  //   return Stack(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(top: 8.0),
  //         child: CircleAvatar(
  //           radius: 45,
  //           backgroundImage:
  //          AssetImage("images/account1.png")
  //
  //         ),
  //       ),
  //       Positioned(
  //           bottom: 1,right: 1,
  //           child: InkWell(
  //               onTap: () {
  //                 showModalBottomSheet(
  //                   context: context, builder: ((builder) => bottomsheet()),
  //                 );
  //               },
  //               child: buildEditIcon(Colors.blue))
  //       ),
  //     ],
  //   );
  // }

  void checkPattern(String text) {
    int i = 2;
    print("onc " + text);
    text += '';
    if (text.isNotEmpty && text.length < 6){
      _passwordErrorText = 'This password less than 6 characters.';

    } else if (text.isNotEmpty && text.length > 5 ) {
      while (i <= text.length) {
        String temp = text.substring(i - 2, i);
        print("temp " + temp);
        temp = temp.toUpperCase();
        if (pattern.contains(temp)) {
          _passwordErrorText = 'This password cannot be used.\nBecause it have sequence of letters or numbers.';
          break;
        } else {
          _passwordErrorText = null;
        }
        i++;
      }
    } else
      _passwordErrorText = null;
    setState(() {

    });
  }
}


