import 'package:cloud_firestore/cloud_firestore.dart';

class StudentRecord {
  final String studentName;
  final int age;
  final Map<dynamic, dynamic> skills;
  final String image;

  final DocumentReference reference;

  StudentRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['studentname'] != null),
        studentName = map['studentname'],
        skills = map['skills'],
        age = map['age'],
        image = map['image'];

  StudentRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$studentName";
}
