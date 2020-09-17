import 'package:face_detection_app/RegisterFaceScreen.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _txtUsername, _txtPassword;

  @override
  void initState() {
    super.initState();

    _txtPassword = new TextEditingController();
    _txtUsername = new TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(child: Column(children: [
          
          Container(
            margin: EdgeInsets.only(top:50),
            alignment: Alignment.center,
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset('asset/skull.png',width: 150,),],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top:30,bottom:10),
            child: Text('Face Detection App', style: TextStyle(fontSize: 20),),
          ),

          Container(
            margin: EdgeInsets.only(top:10,left:50,right:50),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Username'
              ),
              controller: _txtUsername,
            ),
          ),

          
          Container(
            margin: EdgeInsets.only(top:10,left:50,right:50),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Password'
              ),
              obscureText: true,
              controller: _txtPassword,
            ),
          ),


          Container(
            margin: EdgeInsets.only(top:30,left:20,right:20),
            width: 150,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5)
            ),
            child: FlatButton(
              child: Text('Login',style: TextStyle(color: Colors.white),),
              onPressed: (){
                if (_txtUsername.text == 'admin' && _txtPassword.text == '123456') {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new RegisterFaceScreen()));
                }
                else print('login failed');
              },
            ),
          )
        ],),
      ),),
    );
  }
}
