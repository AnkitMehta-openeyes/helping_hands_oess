import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../sizeconfig.dart';
import 'SignupForm.dart';
import "package:url_launcher/url_launcher.dart";


class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  File _pickedImage;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      persistentFooterButtons: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
                child: Text('Privacy Policy'),
                onTap: () => launch('https://www.openeyessurveys.com/privacy-policy')
            ),
            Container(
                height: 20,
                child: VerticalDivider(
                    thickness: 1,
                    color: Colors.black
                )
            ),
            SizedBox(width: 3,),
            InkWell(
                child: Text('Terms of Use'),
                onTap: () => launch('https://www.openeyessurveys.com/terms-of-use')
            ),
          ],
        ),
        Text('© 2020 & powered by OpenEyes Technologies Inc.'),
      ],
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                  Text("Register Account",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.5,
                      )
                  ),
                  Text(
                    "Complete your details",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40,
                          child: _pickedImage == null ? Icon(Icons.person) : null,
                          backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
                        ),
                        Padding(
                          padding: EdgeInsets.all(0.0),
                          child: GestureDetector(
                              onTap: () {
                                _showPickOptionsDialog(context);
                              },
                              child: Icon(
                                Icons.camera_alt_outlined,
                              )
                          ),
                        ),
                      ]
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  SignUpForm(),
                  /*SizedBox(height: SizeConfig.screenHeight * 0.08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset('logos/google.jpg'),
                        iconSize: 50,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Image.asset('logos/facebook.jpg'),
                        iconSize: 50,
                        onPressed: () {},
                      ),
                    ],
                  ),*/
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Text(
                    'By continuing your confirm that you agree \nwith our Term and Condition',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loadPicker(ImageSource source) async {
    File picked = await ImagePicker.pickImage(source: source);
    if (picked != null) {
      _cropImage(picked);
    }
    Navigator.pop(context);
  }

  _cropImage(File picked) async {
    File cropped = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        statusBarColor: Colors.red,
        toolbarColor: Colors.red,
        toolbarTitle: "Crop Image",
        toolbarWidgetColor: Colors.white,
      ),
      sourcePath: picked.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3,
      ],
      maxWidth: 800,
    );
    if (cropped != null) {
      setState(() {
        _pickedImage = cropped;
      });
    }
  }


  void _showPickOptionsDialog(BuildContext context) {
    showDialog(context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Pick from Gallery'),
                onTap: (){
                  _loadPicker(ImageSource.gallery);
                },
              ),
              ListTile(
                title: Text('Take a Picture'),
                onTap: (){
                  _loadPicker(ImageSource.camera);
                },
              ),
            ],
          ),
        )
    );
  }
}
