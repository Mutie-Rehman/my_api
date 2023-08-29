// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
/*
We have learnt how to upload images using api. For that we have a text and a button which are 
used to open the camera and upload the images respectively. And for that purpose we have two 
functions getImage and uploadImage.
The getImage function is async which waits for the picture. The we have a _picket which is the
instance of the ImagePicker.In that we capture the image. await is used to wait before we get 
the image. Then we have an if-else in which we store the path of the picked file.
Then we have the uploadImage function which is also async. there is a spinner while we have to
wait for the image.Then we have to wait while we fetch the length of the image. Then we have the
API which we have used.And then we have the method to upload the image.

 */

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print("No image selected");
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = http.MultipartRequest('POST', uri);
    request.fields['title'] = 'Static field';
    var multiPort = http.MultipartFile('image', stream, length);
    request.files.add(multiPort);
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print("Image Uploaded");
    } else {
      print('Cannot Upload Image');
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Upload Images"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: image == null
                  ? InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: const Center(
                        child: Text("Pick Image"),
                      ),
                    )
                  : Center(
                      child: Image.file(
                        File(image!.path).absolute,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                uploadImage();
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                    child: Text(
                  "Upload",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
