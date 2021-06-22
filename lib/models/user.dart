import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String url;
  final String profileName;
  final String bio;

  User({
    this.id,
    this.username,
    this.email,
    this.url,
    this.profileName,
    this.bio,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.id,
      email: doc.data()['email'],
      username: doc.data()['username'],
      url: doc.data()['url'],
      profileName: doc.data()['displayName'],
    );
  }
}
