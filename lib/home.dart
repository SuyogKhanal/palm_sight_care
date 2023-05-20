// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_field

import 'dart:io';
import 'developerscreen.dart';
import 'package:tflite/tflite.dart';

import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:opencv_4/opencv_4.dart';
import 'package:path_provider/path_provider.dart';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final imagepicker = ImagePicker();
  File? _image;
  List? _output;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.8,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/label.txt",
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future getImagefromcamera() async {
    var image = await imagepicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    detectImage(_image!);
  }

  Future getImagefromGallery() async {
    var image = await imagepicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(newMethod(image));
    });
    detectImage(_image!);
  }

  String newMethod(XFile image) => image.path;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("Palmsightcare"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeveloperScreen()),
                  );
                },
                icon: Icon(Icons.info_outline_rounded))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "Cataract Diagnosis: on-the-go",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    image: _image == null
                        ? DecorationImage(
                      image: AssetImage('assets/bgimg.gif'),
                      fit: BoxFit.cover,
                    )
                        : null,
                ),
                width: MediaQuery.of(context).size.width,
                height: 600.0,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: _image == null
                            ? Text(
                                "Capture/Upload an image",
                                style: TextStyle(
                                    height: 9,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              )
                            : Image.file(File(_image!.path)),
                      ),
                      _output != null
                          ? Container(
                              color: Colors
                                  .black, // set background color of container
                              child: Text(
                                '${_output?[0]['label']}',
                                style: TextStyle(
                                    height: 1,
                                    color: _output?[0]['label'] == 'Cataract'
                                        ? Colors.redAccent
                                        : Colors.white,
                                    fontSize: 28),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  heroTag: null,
                  onPressed: getImagefromcamera,
                  tooltip: "Click new image from camera",
                  child: Icon(Icons.camera_enhance_sharp),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  heroTag: null,
                  onPressed: getImagefromGallery,
                  tooltip: "Pick Image from Gallery",
                  child: Icon(Icons.photo_library_sharp),

                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
