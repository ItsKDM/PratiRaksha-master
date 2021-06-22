import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyNumbers extends StatefulWidget {
  @override
  _EmergencyNumbersState createState() => _EmergencyNumbersState();
}

class _EmergencyNumbersState extends State<EmergencyNumbers> {
  TextEditingController c1;
  @override
  void initState() {
    c1 = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFe5eefc),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0.0,
        backgroundColor: Color(0XFFe5eefc),
        automaticallyImplyLeading: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.black87,
            ),
            onPressed: () {},
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(),
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Emergency Contacts",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.only(left: 20),
                      child: Center(
                        child: TextField(
                          controller: c1,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 20.0,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "phone number".toUpperCase(),
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 17.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        call6();
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            "Call".toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 1,
                          width: 120,
                          color: Colors.red.shade200,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'OR'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.red.shade200,
                            fontSize: 20.0,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 1,
                          width: 120,
                          color: Colors.red.shade200,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        call();
                      },
                      child: Container(
                        child: Row(children: <Widget>[
                          SizedBox(width: 20),
                          Container(
                            child: Text(
                              "Police".toUpperCase(),
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Icon(
                              Icons.phone,
                              color: Colors.red.shade200,
                            ),
                          ),
                          SizedBox(width: 20)
                        ]),
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        call2();
                      },
                      child: Container(
                        child: Row(children: <Widget>[
                          SizedBox(width: 20),
                          Container(
                            child: Text(
                              "CG Women".toUpperCase(),
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Icon(
                              Icons.phone,
                              color: Colors.red.shade200,
                            ),
                          ),
                          SizedBox(width: 20)
                        ]),
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        call3();
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 20),
                            Container(
                              child: Text(
                                "Women helpline".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 15.0,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: Icon(
                                Icons.phone,
                                color: Colors.red.shade200,
                              ),
                            ),
                            SizedBox(width: 20)
                          ],
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        call4();
                      },
                      child: Container(
                        child: Row(children: <Widget>[
                          SizedBox(width: 20),
                          Container(
                            child: Text(
                              "Civil Line".toUpperCase(),
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Icon(
                              Icons.phone,
                              color: Colors.red.shade200,
                            ),
                            // SizedBox()
                          ),
                          SizedBox(width: 20)
                        ]),
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        call5();
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 20),
                            Container(
                              child: Text(
                                "Women Helpline".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 15.0,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: Icon(
                                Icons.phone,
                                color: Colors.red.shade200,
                              ),
                            ),
                            SizedBox(width: 20)
                          ],
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  call() {
    String phoneno = "tel:" + "100";
    launch(phoneno);
  }

  call1() {
    String phoneno = "tel:" + "07714247121";
    launch(phoneno);
  }

  call2() {
    String phoneno = "tel:" + "07712429977";
    launch(phoneno);
  }

  call3() {
    String dial = "tel:" + "07714013189";
    launch(dial);
  }

  call4() {
    String dial = "tel:" + "07714247123";
    launch(dial);
  }

  call5() {
    String dial = "tel:" + "181";
    launch(dial);
  }

  call6() {
    String dial = "tel:" + c1.text;
    launch(dial);
  }
}
