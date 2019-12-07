import 'package:flutter/material.dart';
import 'package:baby_names/multiform/empty_state.dart';
import 'package:baby_names/multiform/form.dart';
import 'package:baby_names/multiform/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<UserForm> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
//        leading: Icon(
//          Icons.wb_cloudy,
//        ),
        title: Text('REGISTER USERS'),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: onSave,
          )
        ],
      ),
      body: Container(
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            colors: [
//              Color(0xFF30C1FF),
//              Color(0xFF2AA7DC),
//            ],
//            begin: Alignment.topCenter,
//            end: Alignment.bottomCenter,
//          ),
//        ),
        child: users.length <= 0
            ? Center(
                child: EmptyState(
                  title: 'Oops',
                  message: 'Add Location by tapping add button below',
                ),
              )
            : ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: users.length,
                itemBuilder: (_, i) => users[i],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
        foregroundColor: Colors.white,
      ),
    );
  }

  ///on form user deleted
  void onDelete(User _user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = User();
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  ///on save forms
  void onSave() {
    if (users.length > 0) {
      var allValid = true;
      users.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = users.map((it) => it.user).toList();
        for(var i =0; i< data.length; i++) {
        Firestore.instance.collection('baby').document(data[i].fullName).setData({'name': data[i].fullName, 'votes': 0});

        };
        Navigator.pop(context);
//
//            () => Firestore.instance.runTransaction((transaction) async {
//          final freshSnapshot = await transaction.get(record.reference);
//          final fresh = Record.fromSnapshot(freshSnapshot);
//
//          await transaction
//              .update(record.reference, {'votes': fresh.votes + 1});
//        }

//        Navigator.push(
//          context,
//          MaterialPageRoute(
////            fullscreenDialog: true,
//            builder: (_) => Scaffold(
//                  appBar: AppBar(
//                    title: Text('List of Users'),
//                  ),
//                  body: ListView.builder(
//                    itemCount: data.length,
//                    itemBuilder: (_, i) => ListTile(
//                          leading: CircleAvatar(
//                            child: Text(data[i].fullName.substring(0, 1)),
//                          ),
//                          title: Text(data[i].fullName),
//                          subtitle: Text(data[i].email),
//                        ),
//                  ),
//                ),
//          ),
//        );
      }
    }
  }
}
