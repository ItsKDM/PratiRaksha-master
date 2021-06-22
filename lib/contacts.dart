import "package:flutter/material.dart";
import 'package:meal_monkey_partner/services/storage.dart';
import 'package:meal_monkey_partner/models/contactModel.dart';
import 'dart:async';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final TextEditingController newContactField = new TextEditingController();

  Future<List<ContactModel>> contacts;
  String number;
  var dbHelper;
  bool isUpdating;
  final formKey = new GlobalKey<FormState>();

  void initState() {
    super.initState();
    dbHelper = Storage();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      contacts = dbHelper.getContacts();
    });
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      ContactModel c = ContactModel(number);
      dbHelper.save(c);
      refreshList();
      newContactField.clear();
    }
  }

  Container numberTable(List<ContactModel> contacts) {
    return Container(
      child: DataTable(
        columns: [
          DataColumn(
            label: Text(
              "Phone Number",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          DataColumn(
            label: Text(""),
          ),
        ],
        rows: contacts
            .map(
              (contact) => DataRow(
                cells: [
                  DataCell(
                    Text(
                      contact.number,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7),
                        letterSpacing: 1.0,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  DataCell(
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        dbHelper.delete(contact.number);
                        refreshList();
                      },
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: contacts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return numberTable(snapshot.data);
          }

          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text("No Numbers Added");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.only(left: 10),
              child: Center(
                child: TextFormField(
                  controller: newContactField,
                  keyboardType: TextInputType.number,
                  validator: (val) =>
                      val.length != 10 ? 'Check your number' : null,
                  onSaved: (val) => number = val,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Number",
                    hintStyle: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFF9F8FD),
                borderRadius: BorderRadius.circular(5),
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
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: validate,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onBackPressed() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: Container(
          color: Color(0XFFe5eefc),
          child: Container(
            padding: EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  list(),
                  Expanded(child: Container()),
                  form(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
