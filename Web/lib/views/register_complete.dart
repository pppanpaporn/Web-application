import 'package:flutter/material.dart';
import 'package:web_application/views/login_page.dart';

class RegisterComplete extends StatefulWidget {
  @override
  _RegisterCompleteState createState() => _RegisterCompleteState();
}

class _RegisterCompleteState extends State<RegisterComplete> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, size: 80,),
                  Text('Register Complete',style: TextStyle(fontSize: 35),),
                ],
              ),
            ),
            Container(
              height: 500,
              child: AspectRatio(
                  aspectRatio: 912 / 912,
                  child: Image.asset(
                    "images/register_complete.png",
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                    color: Color(0xFFF55317),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Text('LOGIN',style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
