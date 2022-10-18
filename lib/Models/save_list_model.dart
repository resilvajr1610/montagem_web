import 'package:flutter/cupertino.dart';

class SaveListModel{
  bool selected;
  bool codRep;
  String letter1;
  String letter2;
  int numberSequence;
  TextEditingController cod;
  TextEditingController ref;
  TextEditingController qtd;
  TextEditingController maker;
  TextEditingController application;
  TextEditingController size;
  TextEditingController comp;
  TextEditingController type;
  String typePrice;
  String typeMarca;
  TextEditingController term1;
  String term1Price;
  String term1Marca;
  TextEditingController term2;
  String term2Price;
  String term2Marca;
  TextEditingController case1;
  String case1Price;
  String case1Marca;
  TextEditingController pos;
  TextEditingController adap1;
  String adap1Price;
  String adap1Marca;
  TextEditingController adap2;
  String adap2Price;
  String adap2Marca;
  TextEditingController anel;
  TextEditingController mola;
  String valorTabela;
  TextEditingController desconto;
  TextEditingController valorUnitario;
  String total;
  String descricao;

  SaveListModel({
    this.selected = false,
    this.codRep = false,
    this.letter1 = 'A',
    this.letter2 = 'A',
    this.numberSequence = 1,
    required this.cod,
    required this.ref,
    required this.qtd,
    required this.maker,
    required this.application,
    required this.size,
    required this.comp,
    required this.type,
    required this.typePrice,
    required this.typeMarca,
    required this.term1,
    required this.term1Price,
    required this.term1Marca,
    required this.term2,
    required this.term2Price,
    required this.term2Marca,
    required this.case1,
    required this.case1Price,
    required this.case1Marca,
    required this.pos,
    required this.adap1,
    required this.adap1Price,
    required this.adap1Marca,
    required this.adap2,
    required this.adap2Price,
    required this.adap2Marca,
    required this.anel,
    required this.mola,
    required this.valorTabela,
    required this.desconto,
    required this.valorUnitario,
    required this.total,
    required this.descricao,
  });
}