
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchCodUnicoModel{

  String _name="";

  SearchCodUnicoModel.fromSnapshot(DocumentSnapshot snapshot):_name = snapshot['codUnico'];

  SearchCodUnicoModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.name = documentSnapshot["codUnico"];
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
