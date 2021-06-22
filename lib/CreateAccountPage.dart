import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String username, restName, number, owner;
  TextEditingController _restNameTextEditingController =
      TextEditingController();
  TextEditingController _userNameTextEditingController =
      TextEditingController();
  TextEditingController _ownerTextEditingController = TextEditingController();
  TextEditingController _numberTextEditingController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  submitUsername() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      SnackBar snackBar =
          SnackBar(content: Text("WELCOME" + " " + restName.toUpperCase()));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 4), () {
        Navigator.pop(
          context,
          restName,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black45,
                  Colors.black54,
                ],
                stops: [0.1, 0.4],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(17.0),
                    child: Container(
                      child: Form(
                        key: _formKey,
                        autovalidate: false,
                        child: Column(
                          children: [
                            SizedBox(height: 35.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              padding: EdgeInsets.only(
                                  top: 10, left: 20, right: 20.0),
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                ),
                                controller: _userNameTextEditingController,
                                validator: (val) {
                                  if (val.trim().length < 5 || val.isEmpty) {
                                    return "UserName is very short";
                                  } else if (val.trim().length > 15) {
                                    return "username is very long";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (val) => username = val,
                                decoration: InputDecoration(
                                    labelText: 'USERNAME',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black54))),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              padding: EdgeInsets.only(
                                  top: 10, left: 20, right: 20.0),
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                ),
                                controller: _restNameTextEditingController,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Enter Canteen Name";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (val) => restName = val,
                                decoration: InputDecoration(
                                    labelText: 'NAME',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black54,
                                    ))),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              padding: EdgeInsets.only(
                                  top: 10, left: 20, right: 20.0),
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                ),
                                controller: _ownerTextEditingController,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Enter Fill";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (val) => owner = val,
                                decoration: InputDecoration(
                                    labelText: 'Blood Group'.toUpperCase(),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black54,
                                    ))),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              padding: EdgeInsets.only(
                                  top: 10, left: 20, right: 20.0),
                              child: TextFormField(
                                controller: _numberTextEditingController,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                ),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Enter Contact Number";
                                  } else if (val.length != 10) {
                                    return ("Please Check");
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (val) => number = val,
                                decoration: InputDecoration(
                                    labelText: 'PHONE NUMBER',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black54,
                                    ))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: 50.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        shadowColor: Colors.greenAccent.shade200,
                        color: Colors.green,
                        elevation: 7.0,
                        child: TextButton(
                          onPressed: () {
                            submitUsername();
                            uploadData(context);
                          },
                          child: Center(
                            child: Text(
                              "Proceed".toUpperCase(),
                              style: TextStyle(
                                letterSpacing: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Container(
                      height: 50.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Center(
                            child: Text(
                              'Cancel'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future uploadData(BuildContext context) async {
    saveItemInfo();
    saveToDatabase();
  }

  //Save Rest Details To Cloud Without Menu
  saveItemInfo() {
    FirebaseFirestore.instance.collection("userDetails").add({
      "Restaurant Name": _restNameTextEditingController.text,
      "Mobile Number": int.parse(_numberTextEditingController.text.trim()),
      "Username": _userNameTextEditingController.text.trim(),
      "Registeration Time": DateTime.now(),
    });
  }

  //Save Rest Details To Database
  void saveToDatabase() {
    var dbTimeKey = new DateTime.now();
    var formatTime = new DateFormat('MMM d, hh:mm aaa');
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = {
      "Restaurant Name": _restNameTextEditingController.text,
      "Mobile Number": _numberTextEditingController.text.trim(),
      "Username": _userNameTextEditingController.text.trim(),
      "Registeration Time": time,
    };
    ref.child("userDetails").push().set(data);
  }
}
