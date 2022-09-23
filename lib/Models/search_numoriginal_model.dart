
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchNumOriginalModel{

  String _name="";

  SearchNumOriginalModel.fromSnapshot(DocumentSnapshot snapshot):_name = snapshot['numoriginal'];

  SearchNumOriginalModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.name = documentSnapshot["numoriginal"];
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
