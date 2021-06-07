import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_application/services/auth.dart';
import 'package:web_application/views/edit_profile.dart';
import 'package:web_application/views/login_page.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'),backgroundColor: Color(0xFFF55317)),
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
          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: CircleAvatar(
                    radius: 150,
                    backgroundImage:
                    AssetImage("images/profile.jpg")
                ),
              ),
              FutureBuilder(
                future: Auth.profile(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data.toString());
                  if(snapshot.hasData&&snapshot.connectionState==ConnectionState.done){
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0,right: 10),
                          child: Text('Firstname : '+snapshot.data["firstname"],style: TextStyle(fontSize: 36)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text('Lastname : '+snapshot.data["lastname"],style: TextStyle(fontSize: 36)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text('Username : '+snapshot.data["username"],style: TextStyle(fontSize: 30)),
                        ),
                      ],
                    );
                  }
                  return Container();
                }
                )
              ],
          ),

          )),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(

          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('/images/bg1.jpg'),
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MENU',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('LOGOUT'),
              onTap: () async {
                bool res = await Auth.logout(box.read('token'));
                if(res){
                  await box.remove("token");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


