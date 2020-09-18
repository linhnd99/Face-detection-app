
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RegisterFace2Screen extends StatefulWidget {
  @override
  RegisterFace2ScreenState createState() => RegisterFace2ScreenState();
}

class RegisterFace2ScreenState extends State<RegisterFace2Screen> {

  CameraController cameraController;
  Future<void> _initializeControllerFuture;
  var cameras;
  bool isNoCamera = false;
  bool isStarted = false;

  int animationTime;

  String statusTrain;

  @override
  void initState() {
    
    super.initState();

    initCamera();

    animationTime = 1000;
    statusTrain = 'Training...';
  }

  void initCamera() async {
    cameras = await availableCameras();
    if (cameras.length == 0) {
      showDialog(context: context, builder: (context) {
        isNoCamera=true;
        return new AlertDialog(
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
        );
      });
      return ;
    }
    cameraController = CameraController(cameras[0], ResolutionPreset.ultraHigh);
    _initializeControllerFuture = cameraController.initialize();
    await _initializeControllerFuture;

    if (mounted) setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Recognize face'),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top:10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4*3,
              child: Center(
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
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

            isNoCamera==false?(!isStarted?Container(
              width: 150,
              margin: EdgeInsets.only(top:20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepPurple
              ),
              child:  FlatButton(
                child: Text('Start',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  setState(() {
                    isStarted = true;
                  });
                },
              )):Container(
                child: CircularPercentIndicator(
                  radius: 100,
                  lineWidth: 5,
                  animation: true,
                  animationDuration: animationTime,
                  percent: 1,
                  center: (statusTrain!='Done'?Text('Training...'):Icon(Icons.done, color: Theme.of(context).primaryColor, size: 40,)),
                  progressColor: Theme.of(context).primaryColor,
                  onAnimationEnd: (){
                    setState(() {
                      setState(() {
                        statusTrain = 'Done';
                      });

                      FlutterRingtonePlayer.playNotification();

                      showDialog(context: context, builder: (context){ 
                        TextEditingController _txtStudentCode = new TextEditingController();
                        return AlertDialog(
                          content: TextField(
                            decoration: InputDecoration(
                              labelText: 'Student code'
                            ),
                            controller: _txtStudentCode,
                          ),
                          actions: [

                            FlatButton(
                              child: Text('Cancel', style: TextStyle(color: Colors.red),),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),

                            FlatButton(
                              child: Text('Save'),
                              onPressed: (){
                                Navigator.pop(context);
                                print('saved face');
                                setState(() {
                                  isStarted=false;
                                });
                                showDialog(context: context, builder: (context){
                                  return SimpleDialog(
                                    children: [
                                      Icon(Icons.done_all, size: 40, color: Theme.of(context).primaryColor,),
                                      Text('Done', textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).primaryColor),),
                                    ],
                                    
                                  );
                                });
                              },
                            )

                          ],
                        );
                      });
                    });
                  },
                ),
                margin: EdgeInsets.only(top:20),
              )
            ):Container(),

          ],
        ),
      ),
    );
  }
}
