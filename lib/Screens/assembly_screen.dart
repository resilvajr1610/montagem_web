import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:montagem_web/Models/save_list_model.dart';
import 'package:montagem_web/Models/save_list_product.dart';
import 'package:montagem_web/Models/search_numoriginal_model.dart';
import 'package:montagem_web/Models/search_product_model.dart';
import 'package:montagem_web/Screens/price_screen.dart';
import '../Models/search_client_model.dart';
import '../Utils/exports.dart';

class AssemblyScreen extends StatefulWidget {
  const AssemblyScreen({Key? key}) : super(key: key);

  @override
  State<AssemblyScreen> createState() => _AssemblyScreenState();
}

class _AssemblyScreenState extends State<AssemblyScreen> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  var _controllerItems = StreamController<QuerySnapshot>.broadcast();
  var _controllerDate = TextEditingController();
  var _controllerClientCod = TextEditingController();
  var _controllerClientName = TextEditingController();
  var _controllerAffiliation = TextEditingController(text: 'Belmap');
  var _controllerCodProduct = TextEditingController();
  var _controllerRef = TextEditingController();
  var _controllerQtd = TextEditingController();
  var _controllerMaker = TextEditingController();
  var _controllerAplication = TextEditingController();
  var _controllerType = TextEditingController();
  var _controllerComp = TextEditingController();
  var _controllerSize = TextEditingController();
  var _controllerTerm1 = TextEditingController();
  var _controllerTerm2 = TextEditingController();
  var _controllerCase = TextEditingController();
  var _controllerPos = TextEditingController();
  var _controllerAdap1 = TextEditingController();
  var _controllerAdap2 = TextEditingController();
  var _controllerAN = TextEditingController();
  var _controllerMO = TextEditingController();
  List _allResultsClient = [];
  List _allResultsProd = [];
  List _allResultsNumOriginal = [];
  List _resultsClient = [];
  List _resultsProd = [];
  List _resultsNumOriginal = [];
  List <SaveListModel> _listSave = [];
  List <SaveListProduct> listProduct = [];
  String valueClient='';
  String valueProd='';
  String valueNumOriginal='';
  String id='';
  String typePrice='';
  String typeMarca='';
  String term1Price='';
  String term1Marca='';
  String term2Price='';
  String term2Marca='';
  String case1Price='';
  String case1Marca='';
  String adap1Price='';
  String adap1Marca='';
  String adap2Price='';
  String adap2Marca='';

  _dataClient(String codcli) async {

    DocumentSnapshot snapshot = await db.collection("clientes").doc(codcli).get();
    Map<String, dynamic>? dataMap = snapshot.data() as Map<String, dynamic>?;
    setState(() {
      _controllerClientName = TextEditingController(text: dataMap?['cliente']);
    });
  }
  _dataSearchProd() async {
    var data = await db.collection("produtos").limit(100).get();
    setState(() {
      _allResultsProd = data.docs;
      _allResultsNumOriginal = data.docs;
    });
    resultSearchListClient();
    _searchNumOriginal();
    return "complete";
  }

  _dataSearchClient() async {

    var data = await db.collection("clientes").limit(100).get();
    setState(() {
      _allResultsClient = data.docs;
    });
    resultSearchListClient();
    return "complete";
  }

  _searchClient() {
    resultSearchListClient();
  }
  _searchProd() {
    resultSearchListProd('');
  }
  _searchNumOriginal() {
    resultSearchListNumOriginal();
  }
  resultSearchListClient() {
    var showResults = [];

    if (_controllerClientName.text != "") {
      for (var items in _allResultsClient) {
        var item = SearchClientModel.fromSnapshot(items).name.toLowerCase();

        if (item.contains(_controllerClientName.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    } else {
      showResults = List.from(_allResultsClient);
    }
    setState(() {
      _resultsClient = showResults;
    });
  }

  resultSearchListProd(String type) {
    var showResults = [];

    if (_controllerTerm1.text != "" && type == 'term1') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.contains(_controllerTerm1.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    }else if(_controllerTerm2.text != "" && type == 'term2') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.contains(_controllerTerm2.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    }else if(_controllerCase.text != "" && type == 'case' ) {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.contains(_controllerCase.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    }else if(_controllerAdap1.text != "" && type == 'adap1') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.contains(_controllerAdap1.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    }else if(_controllerAdap2.text != "" && type == 'adap2') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.contains(_controllerAdap2.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    }else {
      showResults = List.from(_allResultsProd);
    }
    setState(() {
      _resultsProd = showResults;
    });
  }

  resultSearchListNumOriginal() {
    var showResults = [];

      for (var items in _allResultsNumOriginal) {
        var item = SearchNumOriginalModel.fromSnapshot(items).name.toLowerCase();

        if (item.contains(_controllerType.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    setState(() {
      _resultsNumOriginal = showResults;
    });
  }

  createId(){
    CollectionReference create = db.collection("assembly");
    setState(() {
      id = create.doc().id;
      _controllerDate = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
    });
  }

  @override
  void initState() {
    super.initState();
    createId();
    _dataSearchClient();
    _dataSearchProd();
    _controllerClientName.addListener(_searchClient);
    _controllerTerm1.addListener(_searchProd);
    _controllerTerm2.addListener(_searchProd);
    _controllerCase.addListener(_searchProd);
    _controllerAdap1.addListener(_searchProd);
    _controllerAdap2.addListener(_searchProd);
    _controllerType.addListener(_searchNumOriginal);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;

    return Container(
      height: heigth,
      margin: EdgeInsets.only(top: 40.0, bottom: 40, left: 40, right: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: PaletteColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 40),
                  child: TextCustom(
                    text: 'Montagem',
                    size: 20.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ), //Titulo
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  SizedBox(width: 30),
                  Container(
                    width: width * 0.12,
                    child: TextCustom(
                      text: 'Data',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.075,
                    child: TextCustom(
                      text: 'Cliente',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.25,
                    child: TextCustom(
                      text: '',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Container(
                    width: width * 0.1,
                    child: TextCustom(
                      text: 'Filial',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ), //Textos
            Row(
              children: [
                SizedBox(width: 30),
                Container(
                  width: width * 0.12,
                  child: InputRegister(
                    enable: false,
                    controller: _controllerDate,
                    hint: '00/00/0000',
                    fonts: 14.0,
                    keyboardType: TextInputType.datetime,
                    width: width * 0.09,
                    sizeIcon: 0.01,
                    icons: Icons.height,
                    colorBorder: PaletteColors.inputGrey,
                    background: PaletteColors.inputGrey,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      DataInputFormatter(),
                    ],
                    onChanged: (value){},
                  ),
                ),
                Container(
                  width: width * 0.075,
                  child: InputRegister(
                    controller: _controllerClientCod,
                    hint: '00000',
                    fonts: 14.0,
                    keyboardType: TextInputType.number,
                    width: width * 0.05,
                    sizeIcon: 0.01,
                    icons: Icons.height,
                    colorBorder: PaletteColors.inputGrey,
                    background: PaletteColors.inputGrey,
                    onChanged: (value){
                      setState(() {
                        if(value != ''){
                          _dataClient(value.toString());
                        }else{
                          _controllerClientName = TextEditingController(text: '');
                        }
                      });
                    },
                  ),
                ),
                Container(
                  width: width * 0.25,
                  child: InputRegister(
                    controller: _controllerClientName,
                    hint: 'Digite o código do cliente cadastrado',
                    fonts: 14.0,
                    keyboardType: TextInputType.datetime,
                    width: width * 0.2,
                    sizeIcon: 0.01,
                    icons: Icons.height,
                    colorBorder: PaletteColors.inputGrey,
                    background: PaletteColors.inputGrey,
                    onChanged:(value){
                      setState(() {
                        valueClient = value.toString();
                      });
                    },
                  ),
                ),
                Container(
                  width: width * 0.1,
                  child: InputRegister(
                    controller: _controllerAffiliation,
                    hint: 'Belmap',
                    fonts: 14.0,
                    keyboardType: TextInputType.text,
                    width: width * 0.1,
                    sizeIcon: 0.01,
                    icons: Icons.height,
                    colorBorder: PaletteColors.inputGrey,
                    background: PaletteColors.inputGrey,
                    onChanged: (value){},
                  ),
                ),
              ],
            ), //Inputs
            valueClient!=''? Container(
                height: heigth*0.3,
                child: StreamBuilder<QuerySnapshot>(
                    stream: _controllerItems.stream,
                    builder: (context,snapshot){
                      return ListView.builder(
                          itemCount: _resultsClient.length,
                          itemBuilder: (contect,index){
                            DocumentSnapshot item = _resultsClient[index];

                              return ListTile(
                                title: Text('CÓDIGO: ${item['codcli']}, CLIENTE: ${item['cliente']}, ENDEREÇO: ${item['enderent']}, CIDADE: ${item['municient']}'),
                                onTap: ()=>setState(() {
                                  _controllerClientName = TextEditingController(text: item['cliente']);
                                  _controllerClientCod = TextEditingController(text: item['codcli']);
                                  valueClient='';
                                }),
                              );
                          }
                      );
                    }
                )
            ):Container(),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 40),
                Container(
                  width: width * 0.06,
                  child: TextCustom(
                    text: 'Cod. Único',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.06,
                  child: TextCustom(
                    text: 'Rêferencia',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.03,
                  child: TextCustom(
                    text: 'Qtd',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.05,
                  child: TextCustom(
                    text: 'Máquina',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.11,
                  child: TextCustom(
                    text: 'Aplicação',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.05,
                  child: TextCustom(
                    text: 'Tipo Mang',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.047,
                  child: TextCustom(
                    text: 'Compri',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.03,
                  child: TextCustom(
                    text: 'T',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.045,
                  child: TextCustom(
                    text: 'Term.1',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.045,
                  child: TextCustom(
                    text: 'Term.2',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.045,
                  child: TextCustom(
                    text: 'Capa',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.035,
                  child: TextCustom(
                    text: 'Pos.',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.045,
                  child: TextCustom(
                    text: 'Adap.1',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.045,
                  child: TextCustom(
                    text: 'Adap.2',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.03,
                  child: TextCustom(
                    text: 'AN',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: width * 0.03,
                  child: TextCustom(
                    text: 'MO',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Container(
                    width: width * 0.06,
                    child: InputRegister(
                      controller: _controllerCodProduct,
                      hint: '0000',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.06,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                  Container(
                    width: width * 0.05,
                    margin: EdgeInsets.only(left: 3),
                    child: InputRegister(
                      controller: _controllerRef,
                      hint: 'AAA',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.05,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                  Container(
                    width: width * 0.035,
                    margin: EdgeInsets.only(left: 8),
                    child: InputRegister(
                      controller: _controllerQtd,
                      hint: '00',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.035,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                  Container(
                    width: width * 0.05,
                    child: InputRegister(
                      controller: _controllerMaker,
                      hint: 'AAA',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.05,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                  Container(
                    width: width * 0.11,
                    child: InputRegister(
                      controller: _controllerAplication,
                      hint: 'AAA',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.11,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                  Container(
                    width: width * 0.05,
                    child: InputRegister(
                      controller: _controllerType,
                      hint: '0000',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.05,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){
                        setState(() {
                          if(value != ''){
                            valueNumOriginal =value.toString();
                            resultSearchListNumOriginal();
                          }else{
                            _controllerType = TextEditingController(text: '');
                            valueNumOriginal='';
                          }
                        });
                      },
                    ),
                  ),
                  Container(
                    width: width * 0.04,
                    child: InputRegister(
                      controller: _controllerComp,
                      hint: '0,00',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.04,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                  Container(
                    width: width * 0.035,
                    child: InputRegister(
                      controller: _controllerSize,
                      hint: 'PP',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.035,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                  Container(
                    width: width * 0.045,
                    child: InputRegister(
                      controller: _controllerTerm1,
                      hint: '000',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.045,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){
                        setState(() {
                          setState(() {
                            if(value != ''){
                                valueProd =value.toString();
                                resultSearchListProd('term1');
                            }else{
                              _controllerTerm1 = TextEditingController(text: '');
                              valueProd='';
                            }
                          });
                        });
                      },
                    ),
                  ),
                  Container(
                    width: width * 0.045,
                    child: InputRegister(
                      controller: _controllerTerm2,
                      hint: '000',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.045,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){
                        setState(() {
                          setState(() {
                            if(value != ''){
                              valueProd =value.toString();
                              resultSearchListProd('term2');
                            }else{
                              _controllerTerm2 = TextEditingController(text: '');
                              valueProd='';
                            }
                          });
                        });
                      },
                    ),
                  ),
                  Container(
                    width: width * 0.045,
                    child: InputRegister(
                      controller: _controllerCase,
                      hint: '000',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.45,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){
                        setState(() {
                          setState(() {
                            if(value != ''){
                              valueProd =value.toString();
                              resultSearchListProd('case');
                            }else{
                              _controllerCase = TextEditingController(text: '');
                              valueProd='';
                            }
                          });
                        });
                      },
                    ),
                  ),
                  Container(
                    width: width * 0.032,
                    child: InputRegister(
                      controller: _controllerPos,
                      hint: '',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.032,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                  Container(
                    width: width * 0.045,
                    child: InputRegister(
                      controller: _controllerAdap1,
                      hint: '',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.045,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){
                        setState(() {
                          setState(() {
                            if(value != ''){
                              valueProd =value.toString();
                              resultSearchListProd('adap1');
                            }else{
                              _controllerAdap1 = TextEditingController(text: '');
                              valueProd='';
                            }
                          });
                        });
                      },
                    ),
                  ),
                  Container(
                    width: width * 0.045,
                    child: InputRegister(
                      controller: _controllerAdap2,
                      hint: '',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.045,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){
                        setState(() {
                          setState(() {
                            if(value != ''){
                              valueProd =value.toString();
                              resultSearchListProd('adap2');
                            }else{
                              _controllerAdap2 = TextEditingController(text: '');
                              valueProd='';
                            }
                          });
                        });
                      },
                    ),
                  ),
                  Container(
                    width: width * 0.03,
                    child: InputRegister(
                      controller: _controllerAN,
                      hint: '',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.03,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                  Container(
                    width: width * 0.03,
                    child: InputRegister(
                      controller: _controllerMO,
                      hint: '',
                      fonts: 12.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.03,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                ],
              ),
            ),
            valueProd!=''? Container(
                height: heigth*0.3,
                child: StreamBuilder<QuerySnapshot>(
                    stream: _controllerItems.stream,
                    builder: (context,snapshot){
                      return ListView.builder(
                          itemCount: _resultsProd.length,
                          itemBuilder: (contect,index){
                            DocumentSnapshot item = _resultsProd[index];

                            return ListTile(
                              title: Text('CÓDIGO: ${item['codprod']}, MARCA: ${item['marca']}, ESTOQUE 1: ${item['estf1']}, ESTOQUE 2: ${item['estf2']}, PREÇO: ${item['preco']}'),
                              onTap: ()=>setState(() {
                                if(_controllerCodProduct.text.isNotEmpty){
                                  if(_controllerTerm1.text.isNotEmpty && valueProd == _controllerTerm1.text){
                                    _controllerTerm1 = TextEditingController(text: item['codprod']);
                                    term1Price = item['preco'];
                                    term1Marca = item['marca'];
                                  }
                                  if(_controllerTerm2.text.isNotEmpty && valueProd == _controllerTerm2.text){
                                    _controllerTerm2 = TextEditingController(text: item['codprod']);
                                    term2Price = item['preco'];
                                    term2Marca = item['marca'];
                                  }
                                  if(_controllerCase.text.isNotEmpty && valueProd == _controllerCase.text){
                                    _controllerCase = TextEditingController(text: item['codprod']);
                                    case1Price = item['preco'];
                                    case1Marca = item['marca'];
                                  }
                                  if(_controllerAdap1.text.isNotEmpty && valueProd == _controllerAdap1.text){
                                    _controllerAdap1 = TextEditingController(text: item['codprod']);
                                    adap1Price = item['preco'];
                                    adap1Marca = item['marca'];
                                  }
                                  if(_controllerAdap2.text.isNotEmpty && valueProd == _controllerAdap2.text){
                                    _controllerAdap2 = TextEditingController(text: item['codprod']);
                                    adap2Price = item['preco'];
                                    adap2Marca = item['marca'];
                                  }
                                  valueProd='';
                                  listProduct.add(
                                      SaveListProduct(
                                          cod: item['codprod'],
                                          codUnico: _controllerCodProduct.text,
                                          ref: 'ref',
                                          qtd: '0',
                                          fabricante: item['marca'],
                                          valorTabela: item['preco'],
                                          desconto: '0',
                                          valorUnitario: item['preco'],
                                          total: item['preco']
                                      )
                                  );
                                }
                              }),
                            );
                          }
                      );
                    }
                )
            ):Container(),
            valueNumOriginal!=''? Container(
                height: heigth*0.3,
                child: StreamBuilder<QuerySnapshot>(
                    stream: _controllerItems.stream,
                    builder: (context,snapshot){
                      return ListView.builder(
                          itemCount: _resultsNumOriginal.length,
                          itemBuilder: (contect,index){
                            DocumentSnapshot item = _resultsNumOriginal[index];

                            return ListTile(
                              title: Text('NUMERO ORIGINAL: ${item['numoriginal']},CÓDIGO: ${item['codprod']}, MARCA: ${item['marca']}, ESTOQUE 1: ${item['estf1']}, ESTOQUE 2: ${item['estf2']}, PREÇO: ${item['preco']}'),
                              onTap: ()=>setState(() {
                                _controllerType = TextEditingController(text: item['numoriginal']);
                                typePrice = item['preco'];
                                typeMarca = item['marca'];
                                valueNumOriginal='';
                              }),
                            );
                          }
                      );
                    }
                )
            ):Container(),
            _listSave.length!=0?Container(
              height: _listSave.length*50,
              child: ListView.builder(
                  itemCount: _listSave.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.05,
                            height: 40,
                            child: Text(_listSave[index].cod,style: TextStyle(color: PaletteColors.grey),),
                          ),
                          SizedBox(width: 3),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.04,
                            height: 40,
                            child: Text(_listSave[index].ref,style: TextStyle(color: PaletteColors.grey)),
                          ),
                          SizedBox(width: 4),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.025,
                            height: 40,
                            child: Text(_listSave[index].qtd,style: TextStyle(color: PaletteColors.grey)),
                          ),
                          SizedBox(width: 2),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.04,
                            height: 40,
                            child: Text(_listSave[index].maker,style: TextStyle(color: PaletteColors.grey)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.1,
                            height: 40,
                            child: Text(_listSave[index].application,style: TextStyle(color: PaletteColors.grey)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.04,
                            height: 40,
                            child: Text(_listSave[index].type,style: TextStyle(color: PaletteColors.grey)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.03,
                            height: 40,
                            child: Text(_listSave[index].comp,style: TextStyle(color: PaletteColors.grey)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.025,
                            height: 40,
                            child: Text(_listSave[index].size,style: TextStyle(color: PaletteColors.grey)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.035,
                            height: 40,
                            child: Text(_listSave[index].term1,style: TextStyle(color: PaletteColors.grey)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.035,
                            height: 40,
                            child: Text(_listSave[index].term2,style: TextStyle(color: PaletteColors.grey)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.035,
                            height: 40,
                            child: Text(_listSave[index].case1,style: TextStyle(color: PaletteColors.grey)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.022,
                            height: 40,
                            child: Text(_listSave[index].pos,style: TextStyle(color: PaletteColors.grey)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.035,
                            height: 40,
                            child: Text(_listSave[index].adap1,style: TextStyle(color: PaletteColors.grey)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.035,
                            height: 40,
                            child: Text(_listSave[index].adap2,style: TextStyle(color: PaletteColors.grey)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.02,
                            height: 40,
                            child: Text(_listSave[index].anel,style: TextStyle(color: PaletteColors.grey)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                color: PaletteColors.inputGrey,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: PaletteColors.inputGrey,)
                            ),
                            width: width * 0.02,
                            height: 40,
                            child: Text(_listSave[index].mola,style: TextStyle(color: PaletteColors.grey)),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ):Container(),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 40),
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: PaletteColors.primaryColor,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: PaletteColors.white,
                        size: 16.0,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 20,
                        maxWidth: 20,
                        minHeight: 20,
                        maxHeight: 20,
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        if(_controllerClientName.text.isNotEmpty && _controllerCodProduct.text.isNotEmpty && _controllerMaker.text.isNotEmpty && _controllerType.text.isNotEmpty){
                          setState(() {
                            _listSave.add(
                                SaveListModel(
                                    cod: _controllerCodProduct!=null?_controllerCodProduct.text:'',
                                    ref: _controllerRef!=null?_controllerRef.text:'',
                                    qtd: _controllerQtd!=null?_controllerQtd.text:'',
                                    maker: _controllerMaker!=null?_controllerMaker.text:'',
                                    application: _controllerAplication!=null?_controllerAplication.text:'',
                                    size: _controllerSize!=null?_controllerSize.text:'',
                                    type: _controllerType!=null?_controllerType.text:'',
                                    typePrice: typePrice,
                                    typeMarca: typeMarca,
                                    comp: _controllerComp!=null?_controllerComp.text:'',
                                    term1: _controllerTerm1!=null?_controllerTerm1.text:'',
                                    term1Price: term1Price,
                                    term1Marca: term1Marca,
                                    term2: _controllerTerm2!=null?_controllerTerm2.text:'',
                                    term2Price: term2Price,
                                    term2Marca: term2Marca,
                                    case1: _controllerCase!=null?_controllerCase.text:'',
                                    case1Price: case1Price,
                                    case1Marca: case1Marca,
                                    pos: _controllerPos!=null?_controllerPos.text:'',
                                    adap1: _controllerAdap1!=null?_controllerAdap1.text:'',
                                    adap1Price: adap1Price,
                                    adap1Marca: adap1Marca,
                                    adap2: _controllerAdap2!=null?_controllerAdap2.text:'',
                                    adap2Price: adap2Price,
                                    adap2Marca: adap2Marca,
                                    anel: _controllerAN!=null?_controllerAN.text:'',
                                    mola: _controllerMO!=null?_controllerMO.text:'',
                                    valorTabela: 'R\S 0,00',
                                    desconto: 'R\S 0,00',
                                    valorUnitario: 'R\S 0,00',
                                    total: 'R\S 0,00',
                                )
                            );
                            _controllerCodProduct.clear();
                            _controllerRef.clear();
                            _controllerQtd.clear();
                            _controllerMaker.clear();
                            _controllerAplication.clear();
                            _controllerSize.clear();
                            _controllerType.clear();
                            _controllerComp.clear();
                            _controllerTerm1.clear();
                            _controllerTerm2.clear();
                            _controllerCase.clear();
                            _controllerPos.clear();
                            _controllerAdap1.clear();
                            _controllerAdap2.clear();
                            _controllerAN.clear();
                            _controllerMO.clear();
                          });
                        }
                      }
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: PaletteColors.primaryColor,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.control_point_duplicate,
                        color: PaletteColors.white,
                        size: 16.0,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 20,
                        maxWidth: 20,
                        minHeight: 20,
                        maxHeight: 20,
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 100),
                  child: ButtonCustom(
                    widthCustom: 0.1,
                    heightCustom: 0.07,
                    text: "Gravar",
                    size: 12.0,
                    colorText: PaletteColors.white,
                    colorButton: PaletteColors.primaryColor,
                    colorBorder: PaletteColors.primaryColor,
                    font: 'Nunito',
                    onPressed: () {
                      List aux = [];
                      List auxPrice = [];
                      for(var i=0;_listSave.length>i;i++){
                       aux.add(
                           'cod#${_listSave[i].cod}#ref#${_listSave[i].ref}#qtd#${_listSave[i].qtd}#maker#${_listSave[i].maker}'
                           '#aplication#${_listSave[i].application}#numoriginal#${_listSave[i].type}#comprimento#${_listSave[i].comp}'
                           '#type#${_listSave[i].size}#typePrice#${_listSave[i].typePrice}#typeMarca#${_listSave[i].typeMarca}'
                           '#term1#${_listSave[i].term1}#term1Price#${_listSave[i].term1Price}#term1Marca#${_listSave[i].term1Marca}'
                           '#term2#${_listSave[i].term2}#term2Price#${_listSave[i].term2Price}#term2Marca#${_listSave[i].term2Marca}'
                           '#capa#${_listSave[i].case1}#capaPrice#${_listSave[i].case1Price}#capa1Marca#${_listSave[i].case1Marca}'
                           '#pos#${_listSave[i].pos}#adap1#${_listSave[i].adap1}#adap1Price#${_listSave[i].adap1Price}#adap1Marca#${_listSave[i].adap1Marca}'
                           '#adap2#${_listSave[i].adap2}#adap2Price#${_listSave[i].adap2Price}#adap2Marca#${_listSave[i].adap2Marca}#anel#${_listSave[i].anel}#mola#${_listSave[i].mola}'
                       );
                      }
                      for(var i=0;listProduct.length>i;i++){
                        auxPrice.add(
                            'cod#${listProduct[i].cod}#codUnico#${listProduct[i].codUnico}#ref#${listProduct[i].ref}#qtd#${listProduct[i].qtd}#'
                            'fabricante#${listProduct[i].fabricante}#valorTabela#${listProduct[i].valorTabela}#desconto#${listProduct[i].desconto}#'
                            'valorUnitario#${listProduct[i].valorUnitario}#total#${listProduct[i].total}'
                        );
                      }
                      if(aux.length != 0 ){
                        FirebaseFirestore.instance.collection('assembly').doc(id).set({
                          'id':id,
                          'data':_controllerDate!=null?_controllerDate.text:'',
                          'codcli':_controllerClientCod!=null?_controllerClientCod.text:'',
                          'cliente':_controllerClientName!=null?_controllerClientName.text:'',
                          'filial':_controllerAffiliation!=null?_controllerAffiliation.text:'',
                          'produtos':aux.toList(),
                          'prodPrecos':auxPrice.toList(),
                          'dateOrder':DateTime.now()
                        }).then((value){
                          _controllerCodProduct.clear();
                          _controllerRef.clear();
                          _controllerQtd.clear();
                          _controllerMaker.clear();
                          _controllerAplication.clear();
                          _controllerSize.clear();
                          _controllerType.clear();
                          _controllerComp.clear();
                          _controllerTerm1.clear();
                          _controllerTerm2.clear();
                          _controllerCase.clear();
                          _controllerPos.clear();
                          _controllerAdap1.clear();
                          _controllerAdap2.clear();
                          _controllerAN.clear();
                          _controllerMO.clear();
                          Navigator.push(context, new MaterialPageRoute(builder: (context) => new
                            PriceScreen(saveListModel: _listSave,saveListProduct: listProduct,idAssembly: id,client: _controllerClientName.text,codClient: _controllerClientCod.text,))
                          );
                        });
                      }
                    },
                  ),
                ),
                // SizedBox(width: 15),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: ButtonCustom(
                //     widthCustom: 0.14,
                //     heightCustom: 0.07,
                //     text: "Resumo de montagem",
                //     size: 12.0,
                //     colorText: PaletteColors.white,
                //     colorButton: PaletteColors.primaryColor,
                //     colorBorder: PaletteColors.primaryColor,
                //     font: 'Nunito',
                //     onPressed: () {
                //       if(_listSave.length!=0){
                //       }
                //     },
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
