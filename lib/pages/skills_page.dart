import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baby_names/pages/student_record.dart';

class Skills extends StatelessWidget {
//  final String data;
  final Map<dynamic, dynamic> skills;

  Skills({Key key, @required this.skills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Progress'),
      ),
      body: _buildListItem(context, skills),
    );
  }

  Widget _buildListItem(BuildContext context, Map<dynamic, dynamic> skills) {
    return Padding(
//      key: ValueKey(studentName),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: new ListView.builder(
            padding: const EdgeInsets.only(top: 10.0),
            itemCount: skills.length,
            itemBuilder: (BuildContext context, int index) {
              String key = skills.keys.elementAt(index);
//            return new Row(
//              children: <Widget>[
//                new Text('${key} : '),
//                new Text(skills[key].toString())
//              ],
//            );
              return Padding(
                key: ValueKey(key),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ListTile(
                    isThreeLine: true,
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/$key.png'),
                    ),
                    title: Text(key),
                    trailing: Icon(
                      Icons.check_box,
                      color: skills[key] ? Colors.green[500] : Colors.grey,
                    ),
                    subtitle: Text('Notes : Need to improve standing position'),
                    onTap: () {
                      print(skills[key]);
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => Skills(skills: record.skills)),
//                    );
                    },
                  ),
                ),
              );
            },
          )),
    );
  }
}
