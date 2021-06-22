import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Recent ",
              style: TextStyle(color: Colors.black87.withOpacity(0.7)),
            ),
            Text(
              "Accidents",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("incidentReport")
                .orderBy("publishedData", descending: true)
                .snapshots(),
            builder: (context, dataSnapshot) {
              if (!dataSnapshot.hasData)
                return Center(
                  child: Text(
                    "Everyone is safe.".toUpperCase(),
                    style: TextStyle(
                      letterSpacing: 1.2,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: dataSnapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot food = dataSnapshot.data.docs[index];
                    return Card(
                      elevation: 1.0,
                      margin: EdgeInsets.all(15.0),
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network(
                              food['thumbnailUrl'],
                              height: 150.0,
                              fit: BoxFit.cover,
                              width: 150.0,
                            ),
                            SizedBox(height: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food['shortInfo'].toString(),
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  food['publishedData'].toString(),
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Loction: " + food['title'],
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Contact: " + food['price'].toString(),
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}
