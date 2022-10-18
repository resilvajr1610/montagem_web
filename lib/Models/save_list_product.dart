import 'package:montagem_web/Utils/exports.dart';

class SaveListProduct{
  String numoriginal;
  String cod;
  String codUnico;
  String ref;
  String qtd;
  String fabricante;
  String valorTabela;
  TextEditingController desconto;
  TextEditingController valorUnitario;
  String total;

  SaveListProduct({
    required this.numoriginal,
    required this.cod,
    required this.codUnico,
    required this.ref,
    required this.qtd,
    required this.fabricante,
    required this.valorTabela,
    required this.desconto,
    required this.valorUnitario,
    required this.total,
  });
}