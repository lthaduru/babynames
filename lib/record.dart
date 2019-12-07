import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String className;
  final String description;
  final String docId;
  final String image;

//  final DocumentSnapshot students;

//  final List<DocumentSnapshot> students;
//  final CollectionReference students;
//  final CollectionReference classes;
//  final int votes;
  final DocumentReference reference;

//  final CollectionReference students;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['classname'] != null),
//        assert(map['votes'] != null),
        className = map['classname'],
        description = map['description'],
        docId = reference.documentID,
        image = map['image'];

//        students = reference.snapshots();

//        students = map['students'];
//        classes = map['Classes'];
//        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference)

  ;

  @override
  String toString() => "Record<$className";
}
