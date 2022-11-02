class ControllersAssemblyListModel{
  String cod;
  String qtd;
  String number;
  String hose;
  String size;
  String length;
  String term1;
  String term2;
  String cape;
  String pos;
  String adap1;
  String adap2;
  String ring;
  String spring;
  String maker;
  String application;

  ControllersAssemblyListModel({
    required this.cod,
    required this.qtd,
    required this.number,
    required this.hose,
    required this.size,
    required this.length,
    required this.term1,
    required this.term2,
    required this.cape,
    required this.pos,
    required this.adap1,
    required this.adap2,
    required this.ring,
    required this.spring,
    this.maker = '',
    this.application = '',
  });
}