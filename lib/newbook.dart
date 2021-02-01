import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stiw2044_bookworm/user.dart';
import 'package:toast/toast.dart';

class NewBook extends StatefulWidget {
  final User user;

  const NewBook({Key key, this.user}) : super(key: key);

  @override
  _NewBookState createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _authorcontroller = TextEditingController();
  final TextEditingController _publishercontroller = TextEditingController();
  final TextEditingController _editioncontroller = TextEditingController();
  final TextEditingController _yearcontroller = TextEditingController();
  final TextEditingController _isbncontroller = TextEditingController();

  File _image;
  String pathAsset = 'assets/images/camera.png';

  String _title, _author, _publisher, _edition, _year, _isbn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOOKWORM',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.orange,
        // fontFamily: 'Gill Sans Ultra Bold',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add New Book',style: TextStyle(color: Colors.white, fontFamily: 'Gill Sans Ultra Bold'),),
        ),
        // body: Center(
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () => {_onPictureSelection()},
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3.2,
                      width: MediaQuery.of(context).size.width / 1.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _image == null
                              ? AssetImage(pathAsset)
                              : FileImage(_image),
                          fit: BoxFit.cover,
                        ),
                        // border: Border.all(
                        //   width: 3.0,
                        //   color: Colors.grey,
                        // ),
                        borderRadius: BorderRadius.all(Radius.circular(
                                5.0) //         <--- border radius here
                            ),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: _titlecontroller,
                    // keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Title',
                    )),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: _authorcontroller,
                    // keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Author',
                    )),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: _publishercontroller,
                    // keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Publisher',
                    )),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: _editioncontroller,
                    // keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Edition',
                    )),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: _yearcontroller,
                    // keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Year',
                    )),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: _isbncontroller,
                    // keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'ISBN',
                    )),
                SizedBox(
                  height: 10,
                ),
                // Center(
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      minWidth: MediaQuery.of(context).size.width / 3,
                      height: 50,
                      child: Text('Cancel'),
                      color: Colors.grey,
                      textColor: Colors.white,
                      elevation: 15,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      // onPressed: _addbook,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      minWidth: MediaQuery.of(context).size.width / 3,
                      height: 50,
                      child: Text('Add'),
                      color: Color.fromRGBO(255, 148, 48, 1),
                      textColor: Colors.white,
                      elevation: 15,
                      onPressed: _addbook,
                      // onPressed: () {
                      //   Navigator.of(context).pop();
                      // },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // ),
              ],
            ),
          ),
        ),
        // ),
      ),
    );
  }

  _onPictureSelection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            //backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: new Container(
              //color: Colors.white,
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Take picture from:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 100,
                        height: 100,
                        child: Text('Camera',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        //color: Color.fromRGBO(101, 255, 218, 50),
                        color: Colors.blueGrey,
                        textColor: Colors.black,
                        elevation: 10,
                        onPressed: () =>
                            {Navigator.pop(context), _chooseCamera()},
                      )),
                      SizedBox(width: 10),
                      Flexible(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 100,
                        height: 100,
                        child: Text('Gallery',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        //color: Color.fromRGBO(101, 255, 218, 50),
                        color: Colors.blueGrey,
                        textColor: Colors.black,
                        elevation: 10,
                        onPressed: () => {
                          Navigator.pop(context),
                          _chooseGallery(),
                        },
                      )),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  void _chooseCamera() async {
    // ignore: deprecated_member_use
    _image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {});
  }

  void _chooseGallery() async {
    // ignore: deprecated_member_use
    _image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {});
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Resize',
            toolbarColor: Colors.orange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _addbook() {
    // String email = user.email;
    print('add book');
    final dateTime = DateTime.now();
    _title = _titlecontroller.text;
    _author = _authorcontroller.text;
    _publisher = _publishercontroller.text;
    _edition = _editioncontroller.text;
    _year = _yearcontroller.text;
    _isbn = _isbncontroller.text;
    String base64Image = base64Encode(_image.readAsBytesSync());

    http.post("http://middleton.000webhostapp.com/stiw2044/php/add_book.php",
        body: {
          "title": _title,
          "author": _author,
          "publisher": _publisher,
          "year": _year,
          "edition": _edition,
          "category": "for exchange",
          "isbn": _isbn,
          "encoded_string": base64Image,
          "cover": _title + "-${dateTime.microsecondsSinceEpoch}",
          "useremail": widget.user.email,
        }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show(
          "Success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        Navigator.pop(context);
      } else {
        // print(res.body+"fail");
        Toast.show(
          "Failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      }
    }).catchError((err) {
      print(err);
    });
  }
}
