
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchClientModel{

  String _name="";

  SearchClientModel.fromSnapshot(DocumentSnapshot snapshot):_name = snapshot['cliente'];

  SearchClientModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.name = documentSnapshot["cliente"];
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
