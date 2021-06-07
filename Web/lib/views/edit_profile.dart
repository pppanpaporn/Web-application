import 'package:flutter/material.dart';
import 'package:web_application/services/auth.dart';
import 'package:web_application/views/edit_imageProfile.dart';

import 'image_profile.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  RegExp digitValidator = RegExp(r"^[a-zA-Z0-9.]{1,12}$");
  String? _usernameErrorText,_passwordErrorText;

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
      appBar: AppBar(title: Text('Edit Profile'),backgroundColor: Color(0xFFF55317)),
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
          child: Container(
            width: 400, height: 800,
            child: Card(
              child: Column(
                children: [
                  Editimage_profile(),
                  FutureBuilder(
                      future: Auth.profile(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        print(snapshot.data.toString());
                        if(snapshot.hasData&&snapshot.connectionState==ConnectionState.done){
                          return Column(
                            children: [
                              topic('Firstname'),
                              dataTopic(data: snapshot.data["firstname"], control: _firstname,),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(29),
                                // ignore: deprecated_member_use
                                child: FlatButton(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                                  color: Color(0xFFF55317),
                                  onPressed: ()  {

                                  },
                                  child: Text('Edit Username',style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              topic('Lastname'),
                              dataTopic(data: snapshot.data["lastname"], control: _lastname,),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(29),
                                // ignore: deprecated_member_use
                                child: FlatButton(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                                  color: Color(0xFFF55317),
                                  onPressed: ()  {},
                                  child: Text('Edit Lastname',style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              topic('Username'),
                              dataTopic(data: snapshot.data["username"], control: _username,),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(29),
                                // ignore: deprecated_member_use
                                child: FlatButton(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                                  color: Color(0xFFF55317),
                                  onPressed: ()  async {
                                    await Auth.editUsername(_username.text,);
                                    final snackBar = SnackBar(
                                      content: Text('Username has changed.'),

                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    setState(() {

                                    });

                                  },
                                  child: Text('Edit Username',style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              topic('Password'),
                              dataTopic(data: "************", control: _lastname,),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(29),
                                // ignore: deprecated_member_use
                                child: FlatButton(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                                  color: Color(0xFFF55317),
                                  onPressed: ()  {},
                                  child: Text('Edit Password',style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: 10),
                              //   child: Text('* Username get A-Z, a-z, 0-9, maximum length 12 characters.',style: TextStyle(fontSize: 12,color: Color(0xFFF55317))),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 20.0,right: 10),
                              //   child: Text('Firstname : '+snapshot.data["firstname"],style: TextStyle(fontSize: 36)),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 20.0),
                              //   child: Text('Lastname : '+snapshot.data["lastname"],style: TextStyle(fontSize: 36)),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 20.0),
                              //   child: Text('Username : '+snapshot.data["username"],style: TextStyle(fontSize: 30)),
                              // ),
                            ],
                          );
                        }
                        return Container();
                      }
                  )
                ],

              ),
            ),
          ),
        ),
      ),
    );
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


  Padding dataTopic({required String data, required var control, var call_function, var detail_errorText}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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

}
