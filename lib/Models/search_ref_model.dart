
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchRefModel{

  String _name="";

  SearchRefModel.fromSnapshot(DocumentSnapshot snapshot):_name = snapshot['ref'];

  SearchRefModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.name = documentSnapshot["ref"];
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
