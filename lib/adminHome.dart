import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meal_monkey_partner/adminMap.dart';
import 'package:meal_monkey_partner/post.dart';
import 'package:meal_monkey_partner/services/storage.dart';
import 'package:sms/sms.dart';
import 'Widgets/custom_button_widget.dart';
import 'adminUpload.dart';
import 'contacts.dart';
import 'details.dart';
import 'models/contactModel.dart';
import 'models/message.dart';

class Home extends StatefulWidget {
  final User gCurrentUser;
  final String userProfileId;
  Home({this.gCurrentUser, this.userProfileId});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  var dbHelper = Storage();
  List<ContactModel> contacts;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  static const platform = const MethodChannel('sendSms');

  Future<Position> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    return position;
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
          color: Colors.black.withOpacity(0.7),
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0XFFe5eefc),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Prati",
            style: TextStyle(color: Colors.black87.withOpacity(0.7)),
          ),
          Text(
            "Raksha",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      content: Text(
        "Your Location has been sent to the contacts.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black.withOpacity(0.7),
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _showSheet() {
    scaffoldState.currentState.showBottomSheet(
      (context) => SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Expanded(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.verified_user,
                    size: 35,
                    color: Colors.red.shade200,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "PratiRaksha Privacy",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "In today's world privacy is a matter of concern."
                        .toUpperCase(),
                    style: TextStyle(
                      letterSpacing: 1.2,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "For us privacy also matters.We only collect your login details & accident location."
                        .toUpperCase(),
                    style: TextStyle(
                      letterSpacing: 1.2,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: Colors.black.withOpacity(0.7)),
                      SizedBox(width: 5),
                      Text(
                        "pratiRaksha@help.co.in",
                        style: TextStyle(
                            letterSpacing: 1.2,
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      backgroundColor: Color(0XFFe5eefc),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0XFFe5eefc),
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/images/menu.svg",
            color: Colors.black87,
          ),
          onPressed: () {
            scaffoldState.currentState.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
            tooltip: "Report Accident",
            icon: Icon(
              Icons.add,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AdminUpload()));
            },
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Prati",
              style: TextStyle(color: Colors.black87.withOpacity(0.7)),
            ),
            Text(
              "Raksha",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Prati Raksha"),
              accountEmail: new Text(
                "We only have what we give.",
              ),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Text(""),
              ),
            ),
            new ListTile(
              title: new Text("Home"),
              trailing: new Icon(Icons.home, color: Colors.black),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Home()))
                    .then((value) {
                  Navigator.pop(context);
                });
              },
            ),
            new ListTile(
              title: new Text("Report Accident"),
              trailing: new Icon(Icons.accessibility_new, color: Colors.black),
              onTap: () async {
                Navigator.of(context)
                    .push(
                        MaterialPageRoute(builder: (context) => AdminUpload()))
                    .then((value) {
                  Navigator.pop(context);
                });
              },
            ),
            new ListTile(
              title: new Text("Add Contact Number"),
              trailing: new Icon(Icons.add, color: Colors.black),
              onTap: () async {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => EmergencyNumbers()))
                    .then((value) {
                  Navigator.pop(context);
                });
              },
            ),
            new ListTile(
              title: new Text("Maps"),
              trailing: new Icon(Icons.map, color: Colors.black),
              onTap: () async {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MapPage()))
                    .then((value) {
                  Navigator.pop(context);
                });
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("About The App"),
              trailing: new Icon(Icons.bubble_chart, color: Colors.black),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0)), //this right here
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Prati",
                                        style: TextStyle(
                                          letterSpacing: 1.2,
                                          color: Colors.black.withOpacity(0.7),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Raksha",
                                        style: TextStyle(
                                          letterSpacing: 1.2,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "By Parth Budhiraja",
                                    style: TextStyle(
                                      letterSpacing: 1.2,
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "There is no exercise better for the heart than reaching down and lifting people up.\n"
                                    .toUpperCase(),
                                style: TextStyle(
                                  letterSpacing: 1.2,
                                  color: Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            new ListTile(
              title: new Text("Contact Us"),
              trailing: new Icon(Icons.help, color: Colors.black),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0)), //this right here
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Prati",
                                        style: TextStyle(
                                          letterSpacing: 1.2,
                                          color: Colors.black.withOpacity(0.7),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Raksha",
                                        style: TextStyle(
                                          letterSpacing: 1.2,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "By Parth Budhiraja",
                                    style: TextStyle(
                                      letterSpacing: 1.2,
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.email,
                                      color: Colors.black.withOpacity(0.7)),
                                  SizedBox(width: 5),
                                  Text(
                                    "pratiRaksha@help.co.in",
                                    style: TextStyle(
                                        letterSpacing: 1.2,
                                        color: Colors.black.withOpacity(0.7),
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            new Divider(),
            new ListTile(
                title: new Text("Logout"),
                trailing: new Icon(Icons.arrow_forward, color: Colors.black),
                onTap: () {}),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(10),
              height: 100,
              child: Text(
                "Made By Parth Budhiraja",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Emergency help\nneeded?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Just press the button for help',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(height: 40),
                    InkWell(
                      onTap: () async {
                        Position position = await getCurrentLocation();
                        contacts = await dbHelper.getContacts();
                        SmsSender sender = new SmsSender();
                        for (int i = 0; i < contacts.length; i++) {
                          await sender
                              .sendSms(new SmsMessage(
                                  contacts[i].number.trim(),
                                  'Help Me ' +
                                      'http://maps.google.com/?q=' +
                                      position.latitude.toString() +
                                      ',' +
                                      position.longitude.toString()))
                              .whenComplete(() => showAlertDialog(context));
                        }
                      },
                      child: CustomButtonWidget(
                        child: Icon(
                          Icons.help_outline,
                          color: Colors.transparent,
                        ),
                        borderWidth: 5,
                        size: 170,
                      ),
                    ),
                    SizedBox(height: 40),
                    // Text(
                    //   'Not sure what to do?',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontSize: 30.0,
                    //     color: Colors.black.withOpacity(0.7),
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PostScreen()));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.03),
                            padding: EdgeInsets.all(20.0 / 2),
                            height: 62,
                            width: 62,
                            decoration: BoxDecoration(
                              color: Color(0xFFF9F8FD),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0XAA92aeff),
                                  blurRadius: 10,
                                  offset: Offset(5, 5),
                                  spreadRadius: 3,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5,
                                  offset: Offset(-5, -5),
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(
                              "assets/images/heart-icon.svg",
                              color: Colors.red.shade200,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EmergencyNumbers()));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.03),
                            padding: EdgeInsets.all(20.0 / 2),
                            height: 62,
                            width: 62,
                            decoration: BoxDecoration(
                              color: Color(0xFFF9F8FD),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0XAA92aeff),
                                  blurRadius: 10,
                                  offset: Offset(5, 5),
                                  spreadRadius: 3,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5,
                                  offset: Offset(-5, -5),
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(
                              "assets/images/icon_2.svg",
                              color: Colors.red.shade200,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ContactList()));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.03),
                            padding: EdgeInsets.all(20.0 / 2),
                            height: 62,
                            width: 62,
                            decoration: BoxDecoration(
                              color: Color(0xFFF9F8FD),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0XAA92aeff),
                                  blurRadius: 10,
                                  offset: Offset(5, 5),
                                  spreadRadius: 3,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5,
                                  offset: Offset(-5, -5),
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: Image.asset("assets/images/add.jpg",
                                color: Colors.red.shade200),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 20),
                      child: InkWell(
                        onTap: () {
                          _showSheet();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFF9F8FD),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0XAA92aeff),
                                blurRadius: 10,
                                offset: Offset(5, 5),
                                spreadRadius: 3,
                              ),
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 5,
                                offset: Offset(-5, -5),
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/images/icon_4.svg",
                              color: Colors.red.shade200,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
