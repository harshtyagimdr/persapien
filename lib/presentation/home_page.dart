import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   File _image;    
  String _uploadedFileURL;


    Future chooseCamera() async {    
   await ImagePicker.pickImage(source: ImageSource.camera).then((image) {    
     setState(() {    
       _image = image ;    
     });    
   });    
 } 

  Future chooseFile() async {    
   await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {    
     setState(() {    
       _image = image ;    
     });    
   });    
 } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text("Persapien"),
    centerTitle: true,
    ),
    drawer: Drawer(),
    floatingActionButton: FloatingActionButton(
      onPressed: (){ _BottomSheet(context);},
      child: Icon(Icons.camera_alt),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: ScreenUtil.instance.setHeight(20),),
          Center(
            child:
            _image != null    
               ? Image.file(    
                   _image,    
                   height: 150, 
                    
                 )    
               : Container(child: Text("No Image Selected"),),
          )
        ],
      ),
    );

  }
 
 void _BottomSheet(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
          return Container(
            child: new Wrap(
            children: <Widget>[
        new ListTile(
            leading: new Icon(Icons.camera),
            title: new Text('Camera'),
            onTap: chooseCamera,          
          ),
          new ListTile(
            leading: new Icon(Icons.file_upload),
            title: new Text('File'),
            onTap:chooseFile,        
          ),
            ],
          ),
          );
      }
    );
}

}

