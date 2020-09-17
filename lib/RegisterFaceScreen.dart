import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterFaceScreen extends StatefulWidget {
  @override
  _RegisterFaceScreenState createState() => _RegisterFaceScreenState();
}

class _RegisterFaceScreenState extends State<RegisterFaceScreen> {

  List<PickedFile> listImage;

  @override
  void initState() {
    super.initState();

    listImage = new List<PickedFile>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        title: Text('Register face'),
        actions: [
          FlatButton(
            //child: Text('Save',style: TextStyle(color: Colors.white, fontSize: 16),),
            child: Icon(Icons.save, color: Colors.white,),
            onPressed: (){
              showDialog(context: context, builder: (context){
                TextEditingController txtName = new TextEditingController();
                return AlertDialog(
                  content: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                      controller: txtName,
                    ),
                  ),
                  actions: [
                    FlatButton(
                      child: Text('Cancel',style: TextStyle(color: Colors.red),),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text('Save'),
                      onPressed: (){

                        print('Saved ${txtName.text} !');
                        Navigator.pop(context);
                        Navigator.pop(context);

                      },
                    ),
                  ],
                );
              });
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4
          ),
          itemCount: listImage.length+1,
          itemBuilder: (BuildContext context, int index){
            if (index==listImage.length) {
              return GestureDetector(
                child: Card(
                  elevation: 3,
                  child: Container(
                    child: Icon(Icons.add, color: Colors.grey,),
                  ),
                ),
                onTap: () async{

                  PickedFile image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
                  if (image==null) return;

                  setState(() {
                    listImage.add(image);
                  });
                },
              );
            }
            return GestureDetector(
              child: Card(
                elevation: 3,
                child: Container(
                  child: Image.file(File(listImage[index].path)),
                ),
              ),
              onTap: (){

              },
            );
          }),
      ),
    );
  }
}