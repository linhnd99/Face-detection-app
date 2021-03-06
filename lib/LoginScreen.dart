
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';


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

    //LoadModel();
  }

  LoadModel() async {
    var res = await Tflite.loadModel(
        model: "assets/MobileFaceNet.tflite",
        numThreads: 1, // defaults to 1
        isAsset: true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate: false // defaults to false, set to true to use GPU delegate
    );
    print('res load model: '+res.toString());
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
                if (_txtUsername.text == 'admin' && _txtPassword.text == '123') {
                  //Navigator.push(context, new MaterialPageRoute(builder: (context) => new DetectFaceScreen()));
                  Navigator.pushReplacementNamed(context, '/DetectFaceScreen');
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
