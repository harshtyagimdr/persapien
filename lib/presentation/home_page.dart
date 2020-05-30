import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path; 
import 'package:firebase_storage/firebase_storage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   File _image;    
  String _uploadedFileURL;
  bool isLoading=false;
  var value;
  var id = DateTime.now().millisecondsSinceEpoch;

    Future chooseCamera() async {    
   await ImagePicker.pickImage(source: ImageSource.camera).then((image) {    
     setState(() {    
       _image = image ;    
     });    
   });    
 } 
 Future uploadFile() async {   
   isLoading=true;
    
    
   StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('images/$id/${Path.basename(_image.path)}}');    
   StorageUploadTask uploadTask = storageReference.putFile(_image);    
   await uploadTask.onComplete;    
   print('File Uploaded');   
 
   storageReference.getDownloadURL().then((fileURL) {    
     setState(() {  
      
       _uploadedFileURL = fileURL; 
       print(_uploadedFileURL);
       isLoading=false;  
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
    
    floatingActionButton: FloatingActionButton(
      onPressed: (){ chooseCamera();},
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
                   height:ScreenUtil.instance.setHeight(200), 
                    
                 )    
               : Container(child: Text("No Image Selected"),),
          ),
          SizedBox(height: ScreenUtil.instance.setHeight(20),),

          _image==null || _uploadedFileURL!=null?Container():
          RaisedButton(
            child:Text('Upload',style:TextStyle(color:Colors.white)),
            color:Colors.blue,
            onPressed:uploadFile,
          )
        ],
      ),
    );

  }
 


}

