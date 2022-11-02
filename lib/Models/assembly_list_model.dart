import 'package:flutter/material.dart';

class AssemblyListModel{
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
  TextEditingController hose;
  String hosePrice;
  String hoseBrand;
  double hoseQtd;
  TextEditingController term1;
  String term1Price;
  String term1Brand;
  double term1Qtd;
  TextEditingController term2;
  String term2Price;
  String term2Brand;
  double term2Qtd;
  TextEditingController cape;
  String capePrice;
  String capeBrand;
  double capeQtd;
  TextEditingController pos;
  TextEditingController adap1;
  String adap1Price;
  String adap1Brand;
  double adap1Qtd;
  TextEditingController adap2;
  String adap2Price;
  String adap2Brand;
  double adap2Qtd;
  TextEditingController ring;
  double ringQtd;
  TextEditingController spring;
  double springQtd;
  String valueTable;
  TextEditingController discount;
  TextEditingController valueUnit;
  String total;
  String diameterHose;
  String pressureHose;
  String descTerm1;
  String descTerm2;

  AssemblyListModel({
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
    required this.hose,
    required this.hosePrice,
    required this.hoseBrand,
    required this.hoseQtd,
    required this.term1,
    required this.term1Price,
    required this.term1Brand,
    required this.term1Qtd,
    required this.term2,
    required this.term2Price,
    required this.term2Brand,
    required this.term2Qtd,
    required this.cape,
    required this.capePrice,
    required this.capeBrand,
    required this.capeQtd,
    required this.pos,
    required this.adap1,
    required this.adap1Price,
    required this.adap1Brand,
    required this.adap1Qtd,
    required this.adap2,
    required this.adap2Price,
    required this.adap2Brand,
    required this.adap2Qtd,
    required this.ring,
    required this.ringQtd,
    required this.spring,
    required this.springQtd,
    required this.valueTable,
    required this.discount,
    required this.valueUnit,
    required this.total,
    required this.diameterHose,
    required this.pressureHose,
    required this.descTerm1,
    required this.descTerm2,
  });
}