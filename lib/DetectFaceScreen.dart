import 'package:camera/camera.dart';
import 'package:face_detection_app/RegisterFaceScreen.dart';
import 'package:flutter/material.dart';

import 'RegisterFace2Screen.dart';

class DetectFaceScreen extends StatefulWidget {
  @override
  DetectFaceScreenState createState() => DetectFaceScreenState();
}

class DetectFaceScreenState extends State<DetectFaceScreen> {

  CameraController cameraController;
  Future<void> initializeControllerFuture;
  var cameras;

  @override
  void initState() {
    
    super.initState();

    initCamera();

  }

  void initCamera() async {
    cameras = await availableCameras();
    if (cameras.length == 0) {
      showDialog(context: context, builder: (context) => new AlertDialog(
        content: Text('No camera available'),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: (){
              Navigator.pop(context);
              setState(() {
                
              });
            },
          ),
        ],
      ));
      return ;
    }
    cameraController = CameraController(cameras[0], ResolutionPreset.ultraHigh);
    initializeControllerFuture = cameraController.initialize();
    await initializeControllerFuture;

    if (mounted) setState(() {

    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recognize face'),
        actions: [
          FlatButton(
            child: Icon(Icons.exit_to_app, color: Colors.white,),
            onPressed: (){
              showDialog(context: context, builder: (context) => new AlertDialog(
                content: Text('Do you want to logout?'),
                actions: [
                  FlatButton(
                    child: Text('Cancel', style: TextStyle(color: Colors.red),),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),

                  FlatButton(
                    child: Text('OK',),
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/Login');
                    },
                  )
                ],
              ));
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top:10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4*3,
              child: Center(
                child: FutureBuilder<void>(
                  future: initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the Future is complete, display the preview.
                      return AspectRatio(
                        aspectRatio: cameraController.value.aspectRatio,
                        child: CameraPreview(cameraController),
                      );
                    } else if (cameras == null){
                      // Otherwise, display a loading indicator.
                      return Center(child: CircularProgressIndicator());
                    }
                    else {
                      return Center(child: Text('No camera', style: TextStyle(color: Colors.grey),),);
                    }
                  },
                ),
              ),
            ),

            Container(
              width: 150,
              margin: EdgeInsets.only(top:20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepPurple
              ),
              child: FlatButton(
                child: Text('Register face',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new RegisterFace2Screen())).then((value) async{
                    if (cameras == null || cameras.length==0) return;
                    cameraController = CameraController(cameras[0], ResolutionPreset.ultraHigh);
                    initializeControllerFuture = cameraController.initialize();
                    await initializeControllerFuture;

                    if (mounted) setState(() {
 
                    });
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
