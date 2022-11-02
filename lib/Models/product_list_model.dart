import 'package:montagem_web/Utils/exports.dart';

class ProductListModel{
  String numoriginal;
  String cod;
  String codUnit;
  String ref;
  String qtd;
  String fab;
  String valueTable;
  TextEditingController controllerDiscount;
  TextEditingController controllerValueUnit;
  String total;
  String item;
  String input;
  int indexAssembly;

  ProductListModel({
    required this.numoriginal,
    required this.cod,
    required this.codUnit,
    required this.ref,
    required this.qtd,
    required this.fab,
    required this.valueTable,
    required this.controllerDiscount,
    required this.controllerValueUnit,
    required this.total,
    required this.item,
    required this.input,
    required this.indexAssembly,
  });
}