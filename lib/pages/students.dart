import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baby_names/pages/student_record.dart';
import 'package:baby_names/pages/skills_page.dart';

class Students extends StatelessWidget {
  final String data;

  Students({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Roster'),
      ),
      body: _buildBody(context, data),
    );
  }

  Widget _buildBody(BuildContext context, String classId) {
    print('Class id $classId');

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('/coach/123444/Classes/$classId/students')
          .snapshots(),
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

  Widget _buildListItem(BuildContext context, DocumentSnapshot studentName) {
    final record = StudentRecord.fromSnapshot(studentName);

    return Padding(
      key: ValueKey(studentName),
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
          title: Text(record.studentName),
          subtitle: Text('Age: '+record.age.toString()+'\nPreference : Right hand'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Skills(skills: record.skills)),
            );
          },
        ),
      ),
    );
  }
}
