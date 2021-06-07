import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_application/services/auth.dart';
import 'package:web_application/views/profile_page.dart';
import 'package:web_application/views/register_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  GetStorage box = GetStorage();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 400, height: 500,
                  child: Card(

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: (Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Login'),
                            Container(
                                height: 200,
                                child: AspectRatio(
                                  aspectRatio: 1368/912,
                                  child: Image(image: AssetImage("images/login.png",), fit: BoxFit.cover,),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                   style: TextStyle(color: Color(0xFFF55317)),
                                  controller: _username,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.person,color: Color(0xFFF55317)),
                                    border: OutlineInputBorder(),
                                    hintText: 'Username',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _password,
                                  obscureText: true, style: TextStyle(color: Color(0xFFF55317)),
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.lock,color: Color(0xFFF55317),),
                                    border: OutlineInputBorder(),
                                    hintText: 'Password',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10,bottom: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(29),
                                  // ignore: deprecated_member_use
                                  child: FlatButton(
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                                    color: Color(0xFFF55317),
                                    onPressed: ()  async {
                                      String res = await Auth.login(_username.text, _password.text);
                                      if(res!="error"){
                                        await box.write('token', res);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                                      }
                                    },
                                    child: Text('LOGIN',style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Don't have an account? "),
                                      GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                                          },
                                          child: Text('REGISTER',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFF55317)))),
                                    ],
                                  ),
                                ),
                              )

                            ],
                          )),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
