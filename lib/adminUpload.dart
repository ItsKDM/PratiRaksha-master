import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_monkey_partner/Widgets/loadingWidget.dart';
import 'package:meal_monkey_partner/models/user.dart';
import 'package:intl/intl.dart';

class AdminUpload extends StatefulWidget {
  final User gCurrentUser;
  AdminUpload({this.gCurrentUser});
  @override
  _AdminUploadState createState() => _AdminUploadState();
}

class _AdminUploadState extends State<AdminUpload>
    with AutomaticKeepAliveClientMixin<AdminUpload> {
  bool get wantKeepAlive => true;
  File file;
  TextEditingController _priceTextEditingController = TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _shortInfoTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return file == null ? displayAdminHomeScreen() : displayAdminUploadForm();
  }

  displayAdminHomeScreen() {
    return Scaffold(body: getAdminHomeScreenBody());
  }

  getAdminHomeScreenBody() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Report ".toUpperCase(),
              style: TextStyle(
                letterSpacing: 1.2,
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Incident".toUpperCase(),
              style: TextStyle(
                letterSpacing: 1.2,
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: "Camera",
            icon: Icon(
              Icons.add_a_photo,
              color: Colors.black.withOpacity(0.7),
            ),
            onPressed: () {
              pickFromCamera();
            },
          ),
          IconButton(
            tooltip: "Gallery",
            color: Colors.black.withOpacity(0.7),
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () {
              pickFromPhone();
            },
          ),
        ],
      ),
    );
  }

  pickFromCamera() async {
    // ignore: deprecated_member_use
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      this.file = imageFile;
    });
  }

  pickFromPhone() async {
    // ignore: deprecated_member_use
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      this.file = imageFile;
    });
  }

  displayAdminUploadForm() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.cancel_outlined,
            color: Colors.black.withOpacity(0.7),
          ),
          onPressed: () {
            clearFormInfo();
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "REPORT",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: Colors.red,
              ),
            ),
            onPressed: uploading ? null : () => uploadImageAndSaveItemInfo(),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            uploading ? linearProgress() : Text(""),
            Container(
              height: 230,
              width: MediaQuery.of(context).size.width * 0.8,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(file),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0),
            ),
            ListTile(
              leading: Icon(
                Icons.location_on,
                color: Colors.black,
              ),
              title: Container(
                width: 250.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter Location";
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold),
                  controller: _titleTextEditingController,
                  decoration: InputDecoration(
                    hintText: "LOCATION",
                    hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.black45),
            ListTile(
              leading: Icon(
                Icons.all_inclusive_outlined,
                color: Colors.black,
              ),
              title: Container(
                width: 250.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter Description";
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold),
                  controller: _shortInfoTextEditingController,
                  decoration: InputDecoration(
                    hintText: "DESCRIPTION",
                    hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.black45),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.black,
              ),
              title: Container(
                width: 250.0,
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter Contact Number";
                    } else if (val.length != 10) {
                      return ("Please Check");
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  controller: _priceTextEditingController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold),
                    hintText: "PHONE NUMBER",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.black45),
            SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Text(
            //       "In partnership with".toUpperCase(),
            //       style: TextStyle(
            //         color: Colors.black.withOpacity(0.7),
            //         fontSize: 15,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     SizedBox(width: 5),
            //     Text(
            //       "PIET",
            //       style: TextStyle(
            //         color: Colors.black.withOpacity(0.7),
            //         fontSize: 15,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  clearFormInfo() {
    setState(() {
      file = null;

      // _descriptionTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _priceTextEditingController.clear();
      _titleTextEditingController.clear();
    });
  }

  uploadImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });
    String imageDownloadUrl = await uploadItemImage(file);
    saveItemInfo(imageDownloadUrl);
  }

  Future<String> uploadItemImage(mFileImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("incidentReport");
    UploadTask uploadTask =
        storageReference.child("product_$productId.jpg").putFile(mFileImage);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveItemInfo(String downloadUrl) {
    var dbTimeKey = new DateTime.now();
    var formatTime = new DateFormat('MMM d, hh:mm aaa');
    String time = formatTime.format(dbTimeKey);

    final itemsMenu = FirebaseFirestore.instance.collection("incidentReport");
    itemsMenu.doc(productId).set({
      "shortInfo": _shortInfoTextEditingController.text.trim(),
      "price": int.parse(_priceTextEditingController.text.trim()),
      "publishedData": time,
      "productId": productId,
      "thumbnailUrl": downloadUrl,
      "title": _titleTextEditingController.text.trim()
    });

    setState(() {
      file = null;
      // postId = Uuid().v4();
      uploading = false;
      productId = DateTime.now().millisecondsSinceEpoch.toString();
      _shortInfoTextEditingController.clear();
      _priceTextEditingController.clear();
      _titleTextEditingController.clear();
    });
  }
}
