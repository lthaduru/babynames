import 'package:flutter/material.dart';
import 'package:baby_names/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baby_names/pages/students.dart';
import 'package:baby_names/record.dart';
import 'package:baby_names/multiform/user.dart';
import 'package:baby_names/multiform/form.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
//  List<UserForm> users = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Welcome Jon'),
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/Jon.JPG'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _signOut,
          )
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          Firestore.instance.collection('/coach/123444/Classes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 10.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

//    CollectionReference studentsNames = record.students;
    return Padding(
      key: ValueKey(record.className),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          isThreeLine: true,
          leading: CircleAvatar(
            backgroundImage: AssetImage(record.image),
          ),
          title: Text(record.className),
          subtitle: Text('Description '+record.description),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Students(data: record.docId)),
            );
          },
        ),
      ),
    );
  }
//
//  ///on form user deleted
//  void onDelete(User _user) {
//    setState(() {
//      var find = users.firstWhere(
//        (it) => it.user == _user,
//        orElse: () => null,
//      );
//      if (find != null) users.removeAt(users.indexOf(find));
//    });
//  }
//
//  ///on add form
//  void onAddForm() {
//    setState(() {
//      var _user = User();
//      users.add(UserForm(
//        user: _user,
//        onDelete: () => onDelete(_user),
//      ));
//    });
//  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}
