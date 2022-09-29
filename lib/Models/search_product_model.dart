
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchProdModel{

  String _name="";

  SearchProdModel.fromSnapshot(DocumentSnapshot snapshot):_name = snapshot['numoriginal'];

  SearchProdModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.name = documentSnapshot["numoriginal"];
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
