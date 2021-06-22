import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_monkey_partner/CreateAccountPage.dart';
import 'package:meal_monkey_partner/adminHome.dart';
import 'package:meal_monkey_partner/models/user.dart';

final GoogleSignIn gSignIn = GoogleSignIn();
final usersReference = FirebaseFirestore.instance.collection('AdminUsers');
final Reference storageReference =
    FirebaseStorage.instance.ref().child("Posts Pictures");
final postReference = FirebaseFirestore.instance.collection("posts");
final DateTime timestamp = DateTime.now();
User currentUser;

class AdminEmail extends StatefulWidget {
  @override
  _AdminEmailState createState() => _AdminEmailState();
}

class _AdminEmailState extends State<AdminEmail> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  //ADMIN LOGIN
  bool isSignedIn = false;
  PageController pageController;
  int getPageIndex = 0;

  void initState() {
    super.initState();
    pageController = PageController();
    gSignIn.onCurrentUserChanged.listen((gSigninAccount) {
      controlSignIn(gSigninAccount);
    }, onError: (gError) {
      print("Error Message:" + gError);
    });
  }

  controlSignIn(GoogleSignInAccount signInAccount) async {
    if (signInAccount != null) {
      await saveUserInfoToFireStore();
      setState(() {
        isSignedIn = true;
      });
    } else {
      isSignedIn = false;
    }
  }

  saveUserInfoToFireStore() async {
    final GoogleSignInAccount gCurrentUser = gSignIn.currentUser;
    DocumentSnapshot documentSnapshot =
        await usersReference.doc(gCurrentUser.id).get();

    if (!documentSnapshot.exists) {
      final username = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => CreateAccountPage()));
      usersReference.doc(gCurrentUser.id).set({
        'id': gCurrentUser.id,
        'profileName': gCurrentUser.displayName,
        'username': username,
        'url': gCurrentUser.photoUrl,
        'email': gCurrentUser.email,
        'timestamp': timestamp
      });
      documentSnapshot = await usersReference.doc(gCurrentUser.id).get();
    }

    currentUser = User.fromDocument(documentSnapshot);
  }

  loginUser() {
    gSignIn.signIn();
  }

  logoutUser() {
    gSignIn.signOut();
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  whenPageChanges(int pageIndex) {
    setState(() {
      this.getPageIndex = pageIndex;
    });
  }

  onTapChangePage(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 400), curve: Curves.bounceInOut);
  }

  Widget buildSignInScreen() {
    return Scaffold(
      key: scaffoldState,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/help.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.4),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Pratiraksha",
                  style: TextStyle(
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Prevention is always in your hands!",
                  style: TextStyle(
                      letterSpacing: 1.0, color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: InkWell(
                    onTap: () {
                      loginUser();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'LOGIN WITH GOOGLE',
                          style: TextStyle(
                            letterSpacing: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return Home();
    } else {
      return buildSignInScreen();
    }
  }
}
