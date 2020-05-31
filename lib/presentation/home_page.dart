import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path; 
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
// http://34.87.70.63:8090/api/?url=https://storage.googleapis.com/persapien-6f491.appspot.com/1589009083121download.jpg
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
  String _output_image;
  String url="http://34.87.70.63:8090/api/?url=";

  Future<String> makeRequest(_uploadedFileURL) async{
    var response= await http.post(url+"https://storage.googleapis.com/persapien-6f491.appspot.com/1589009083121download.jpg");
    print(response.body);
    print(response.statusCode);
    if (response.statusCode==200){
      setState(() {
         _output_image=response.body;
      });
    }
  }

    Future chooseCamera() async {    
   await ImagePicker.pickImage(source: ImageSource.camera).then((image) {    
     setState(() {    
       _image = image ;    
     });    
   });    
 } 
 Future uploadFile() async { 
   setState(() {
      isLoading=true;
   });  
  
    
    
   StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('images/$id/${Path.basename(_image.path)}}');    
   StorageUploadTask uploadTask = storageReference.putFile(_image);    
   await uploadTask.onComplete;    
   print('File Uploaded');   
 
   storageReference.getDownloadURL().then((fileURL) async{    
     setState(() {  
      
       _uploadedFileURL = fileURL; 
      //  print(_uploadedFileURL);
      //  print(url+_uploadedFileURL);
      //  
        isLoading=false;  
     });
     if (_uploadedFileURL!=null){
     await makeRequest(_uploadedFileURL);  
      
     }
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
      body: isLoading?Center(
          child: CircularProgressIndicator(),
          ):Column(
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
          ),
          _output_image!=null?
           Image.network( _output_image, )  :Container()

        ],
      ),
    );

  }
 


}

