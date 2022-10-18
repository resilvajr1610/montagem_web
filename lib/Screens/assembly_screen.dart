import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:montagem_web/Models/error_int_model.dart';
import 'package:montagem_web/Models/save_list_model.dart';
import 'package:montagem_web/Models/save_list_product.dart';
import 'package:montagem_web/Models/search_codUnico_model.dart';
import 'package:montagem_web/Models/search_product_model.dart';
import 'package:montagem_web/Models/search_ref_model.dart';
import 'package:montagem_web/Screens/price_screen.dart';
import 'package:montagem_web/Utils/text_const.dart';
import '../Models/search_client_model.dart';
import '../Utils/exports.dart';

class AssemblyScreen extends StatefulWidget {
  final String id;

  AssemblyScreen({required this.id});

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
  List _allResultsClient = [];
  List _allResultsCodUnico = [];
  List _allResultsProd = [];
  List _resultsClient = [];
  List _resultsCodUnico = [];
  List _resultsProd = [];
  List <SaveListModel> _listSave = [];
  List <SaveListProduct> listProduct = [];
  String valueClient='';
  String valueProd='';
  String valuecodProd='';
  int indexGlobal=0;
  int? indexDuplicate;
  String id='';
  String typePrice='0.0';
  String typeMarca='';
  String term1Price='0.0';
  String term1Marca='';
  String term2Price='0.0';
  String term2Marca='';
  String case1Price='0.0';
  String case1Marca='';
  String adap1Price='0.0';
  String adap1Marca='';
  String adap2Price='0.0';
  String adap2Marca='';
  bool loadingCliente=false;
  bool loadingData = true;
  int order=0;
  List listLetter = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','Y','Z'];

  _getOrder()async{
    DocumentSnapshot snapshot = await db.collection('order').doc('order').get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    setState(() {
      order = data?["order"]??0;
      order= order+1;
    });
  }

  _dataClient(String codcli) async {

    DocumentSnapshot snapshot = await db.collection("clientes").doc(codcli).get();
    Map<String, dynamic>? dataMap = snapshot.data() as Map<String, dynamic>?;
    setState(() {
      _controllerClientName = TextEditingController(text: dataMap?['cliente']);
      loadingCliente=false;
    });
  }
  _dataSearchProd() async {
    var data = await db.collection("produtos").get();
    setState(() {
      _allResultsProd = data.docs;
      loadingData=false;
    });
    resultSearchListClient();
    return "complete";
  }

  _dataSearchClient() async {
    var data = await db.collection("clientes").get();
    setState(() {
      _allResultsClient = data.docs;
    });
    resultSearchListClient();
    return "complete";
  }

  _dataSearchCodUnico() async {
    var data = await db.collection("codUnico").get();
    setState(() {
      _allResultsCodUnico = data.docs;
      loadingData=false;
    });
    resultSearchListCodUnico();
    resultSearchListRef();
    return "complete";
  }

  _searchCodUnico() {
    resultSearchListCodUnico();
  }

  _searchRef() {
    resultSearchListRef();
  }

  _searchClient() {
    resultSearchListClient();
  }
  _searchProd() {
    resultSearchListProd('');
  }

  resultSearchListCodUnico() {
    var showResults = [];

    if (_listSave[indexGlobal].cod.text.isNotEmpty) {
      for (var items in _allResultsCodUnico) {
        var item = SearchCodUnicoModel.fromSnapshot(items).name.toUpperCase();

        if (item.startsWith(_listSave[indexGlobal].cod.text.toUpperCase())) {
          setState(() {
            showResults.add(items);
          });
        }
      }
    } else {
      setState(() {
        showResults = List.from(_allResultsCodUnico);
      });
    }
    setState(() {
      _resultsCodUnico = showResults;
    });
  }

  resultSearchListRef() {
    var showResults = [];

    if (_listSave[indexGlobal].ref.text.isNotEmpty) {
      for (var items in _allResultsCodUnico) {
        var item = SearchRefModel.fromSnapshot(items).name.toUpperCase();

        if (item.startsWith(_listSave[indexGlobal].ref.text.toUpperCase())) {
          setState(() {
            showResults.add(items);
          });
        }
      }
    } else {
      setState(() {
        showResults = List.from(_allResultsCodUnico);
      });
    }
    setState(() {
      _resultsCodUnico = showResults;
    });
  }

  resultSearchListClient() {
    var showResults = [];

    if (_controllerClientName.text != "") {
      for (var items in _allResultsClient) {
        var item = SearchClientModel.fromSnapshot(items).name.toLowerCase();

        if (item.startsWith(_controllerClientName.text.toLowerCase())) {
          setState(() {
            showResults.add(items);
          });
        }
      }
    } else {
      setState(() {
        showResults = List.from(_allResultsClient);
      });
    }
    setState(() {
      _resultsClient = showResults;
    });
  }

  resultSearchListProd(String type) {
    var showResults = [];

    if (_listSave[indexGlobal].term1.text != "" && type == 'term1') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.startsWith(_listSave[indexGlobal].term1.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    }else if(_listSave[indexGlobal].term2.text != "" && type == 'term2') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.startsWith(_listSave[indexGlobal].term2.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    }else if(_listSave[indexGlobal].case1.text != "" && type == 'case' ) {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.startsWith(_listSave[indexGlobal].case1.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    }else if(_listSave[indexGlobal].adap1.text != "" && type == 'adap1') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.startsWith(_listSave[indexGlobal].adap1.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    }else if(_listSave[indexGlobal].adap2.text != "" && type == 'adap2') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.startsWith(_listSave[indexGlobal].adap2.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    }else if(_listSave[indexGlobal].type.text != "" && type == 'type') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.startsWith(_listSave[indexGlobal].type.text.toLowerCase())) {
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

  createId(){
    CollectionReference create = db.collection("assembly");
    setState(() {
      id = create.doc().id;
      _controllerDate = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
    });
  }

  insertList(int index){

    double totalTabela = 0;
    double uni =0;

      totalTabela = (double.parse(typePrice) + double.parse(term1Price) + double.parse(term2Price) + double.parse(case1Price) + double.parse(adap1Price) + double.parse(adap2Price))*int.parse(_listSave[index].qtd.text);
      print('totalTabela ${totalTabela}');
      uni = totalTabela / int.parse(_listSave[index].qtd.text);
      print('uni ${uni}');
      setState(() {
        _listSave[index].valorTabela = 'R\$ ${totalTabela.toStringAsFixed(2).replaceAll('.', ',')}';
        _listSave[index].valorUnitario.text = 'R\$ ${uni.toStringAsFixed(2).replaceAll('.', ',')}';
        _listSave[index].total = 'R\$ ${totalTabela.toStringAsFixed(2).replaceAll('.', ',')}';
        totalTabela =0;
        uni =0;
      });

  }

  _addList(){
    var _controllerCodProduct = TextEditingController();
    var _controllerRef = TextEditingController();
    var _controllerQtd = TextEditingController(text: '1');
    var _controllerMaker = TextEditingController();
    var _controllerAplication = TextEditingController();
    var _controllerSize = TextEditingController();
    var _controllerComp = TextEditingController();
    var _controllerType = TextEditingController();
    var _controllerTerm1 = TextEditingController();
    var _controllerTerm2 = TextEditingController();
    var _controllerCase = TextEditingController();
    var _controllerPos = TextEditingController();
    var _controllerAdap1 = TextEditingController();
    var _controllerAdap2 = TextEditingController();
    var _controllerAN = TextEditingController();
    var _controllerMO = TextEditingController();
    setState(() {
        _listSave.add(
            SaveListModel(
              cod: _controllerCodProduct,
              ref: _controllerRef,
              qtd: _controllerQtd,
              maker: _controllerMaker,
              application: _controllerAplication,
              size: _controllerSize,
              comp: _controllerComp,
              type: _controllerType,
              typePrice: typePrice,
              typeMarca: typeMarca,
              term1: _controllerTerm1,
              term1Price: term1Price,
              term1Marca: term1Marca,
              term2: _controllerTerm2,
              term2Price: term2Price,
              term2Marca: term2Marca,
              case1: _controllerCase,
              case1Price: case1Price,
              case1Marca: case1Marca,
              pos: _controllerPos,
              adap1: _controllerAdap1,
              adap1Price: adap1Price,
              adap1Marca: adap1Marca,
              adap2: _controllerAdap2,
              adap2Price: adap2Price,
              adap2Marca: adap2Marca,
              anel: _controllerAN,
              mola: _controllerMO,
              valorTabela: 'R\$ 00,00',
              desconto: TextEditingController(text: '0'),
              valorUnitario: TextEditingController(text: 'R\$ 00,00'),
              total:'R\$ 00,00',
              descricao: '',
            )
        );
    });
  }

  dataEdit()async{
    DocumentSnapshot snapshot = await db.collection("assembly")
        .doc(widget.id)
        .get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    setState(() {
      _controllerClientCod = TextEditingController(text: data?['codcli']??'');
      _controllerClientName = TextEditingController(text: data?['cliente']??'');
      _controllerDate = TextEditingController(text: data?['data']??'');
      _controllerAffiliation = TextEditingController(text: data?['filial']??'');
      List listSaveFirebase = data?['produtos'];
      List  listProductFirebase = data?['prodPrecos'];
      id =  data?['id'];
      order = int.parse(data?['order']);

      for(var i = 0; listSaveFirebase.length>i;i++){
        var splited = listSaveFirebase[i].toString().split('#');

        var _controllerCodProduct = TextEditingController(text: splited[1]);
        var _controllerRef = TextEditingController(text: splited[3]);
        var _controllerQtd = TextEditingController(text: splited[5]);
        var _controllerMaker = TextEditingController(text: splited[7]);
        var _controllerAplication = TextEditingController(text: splited[9]);
        var _controllerSize = TextEditingController(text: splited[11]);
        var _controllerComp = TextEditingController(text: splited[13]);
        var _controllerType = TextEditingController(text: splited[15]);
        var typeP = splited[17];
        var typeFab = splited[19];
        var _controllerTerm1 = TextEditingController(text: splited[21]);
        var term1P = splited[23];
        var term1Fab = splited[25];
        var _controllerTerm2 = TextEditingController(text: splited[27]);
        var term2P = splited[29];
        var term2Fab = splited[31];
        var _controllerCase = TextEditingController(text: splited[33]);
        var caseP = splited[35];
        var caseFab = splited[37];
        var _controllerPos = TextEditingController(text: splited[39]);
        var _controllerAdap1 = TextEditingController(text: splited[41]);
        var adap1P = splited[43];
        var adap1Fab = splited[45];
        var _controllerAdap2 = TextEditingController(text: splited[47]);
        var adap2P = splited[49];
        var adap2Fab = splited[51];
        var _controllerAN = TextEditingController(text: splited[53]);
        var _controllerMO = TextEditingController(text: splited[55]);
        var _descricao = splited[splited.length-1];

            _listSave.add(
                SaveListModel(
                  cod: _controllerCodProduct,
                  ref: _controllerRef,
                  qtd: _controllerQtd,
                  maker: _controllerMaker,
                  application: _controllerAplication,
                  size: _controllerSize,
                  comp: _controllerComp,
                  type: _controllerType,
                  typePrice: typeP,
                  typeMarca: typeFab,
                  term1: _controllerTerm1,
                  term1Price: term1P,
                  term1Marca: term1Fab,
                  term2: _controllerTerm2,
                  term2Price: term2P,
                  term2Marca: term2Fab,
                  case1: _controllerCase,
                  case1Price: caseP,
                  case1Marca: caseFab,
                  pos: _controllerPos,
                  adap1: _controllerAdap1,
                  adap1Price: adap1P,
                  adap1Marca: adap1Fab,
                  adap2: _controllerAdap2,
                  adap2Price: adap2P,
                  adap2Marca: adap2Fab,
                  anel: _controllerAN,
                  mola: _controllerMO,
                  valorTabela: '0',
                  desconto: TextEditingController(text: '0'),
                  valorUnitario: TextEditingController(text: '0'),
                  total:'0',
                  descricao: _descricao,
                )
        );
      }
      _dataSearchClient();
      _dataSearchProd();
      if(_listSave.length!=0){
        _controllerClientName.addListener(_searchClient);
        _listSave[0].cod.addListener(_searchCodUnico);
        _listSave[0].ref.addListener(_searchRef);
        _listSave[0].term1.addListener(_searchProd);
        _listSave[0].term2.addListener(_searchProd);
        _listSave[0].case1.addListener(_searchProd);
        _listSave[0].adap1.addListener(_searchProd);
        _listSave[0].adap2.addListener(_searchProd);
        _listSave[0].type.addListener(_searchProd);
      }
    });
}

init(){
  _addList();
  createId();
  _dataSearchClient();
  _dataSearchProd();
  _dataSearchCodUnico();
  if(_listSave.length!=0){
    _controllerClientName.addListener(_searchClient);
    _listSave[0].cod.addListener(_searchCodUnico);
    _listSave[0].ref.addListener(_searchRef);
    _listSave[0].term1.addListener(_searchProd);
    _listSave[0].term2.addListener(_searchProd);
    _listSave[0].case1.addListener(_searchProd);
    _listSave[0].adap1.addListener(_searchProd);
    _listSave[0].adap2.addListener(_searchProd);
    _listSave[0].type.addListener(_searchProd);
  }
  _getOrder();
}

Future sequenceUpdate(String cod,bool update,int i)async{

  if(update){
    DocumentSnapshot snapshot = await db.collection('codUnico').doc(cod).get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    int rep = ErrorIntModel(data,'rep');
    String letter1='';
    String letter2='';
      letter1 = listLetter[rep<=25?0:rep-25];
      letter2 =  listLetter[(rep / 25).round()];

  db.collection('codUnico').doc(cod).update({
    'rep' : rep+1
  }).then((value) => setState(()=>_listSave[i].cod = TextEditingController(text: '${_listSave[i].cod.text} - $letter1$letter2'))).then((value){
    FirebaseFirestore.instance.collection('codUnico').doc(_listSave[i].cod.text).set({
      'codUnico' : _listSave[i].cod.text,
      'ref' : _listSave[i].ref.text,
      'type': _listSave[i].type.text,
      'typePrice': _listSave[i].typePrice,
      'typeMarca': _listSave[i].typeMarca,
      'term1': _listSave[i].term1.text,
      'term1Price': _listSave[i].term1Price,
      'term1Marca': _listSave[i].term1Marca,
      'term2': _listSave[i].term2.text,
      'term2Price': _listSave[i].term2Price,
      'term2Marca': _listSave[i].term2Marca,
      'case1': _listSave[i].case1.text,
      'case1Price': _listSave[i].case1Price,
      'case1Marca': _listSave[i].case1Marca,
      'pos': _listSave[i].pos.text,
    });
  });

  }else{
    DocumentSnapshot snapshot = await db.collection('order').doc('codSequence').get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    int numberSequence = data?['numberSequence'];
    print('numberSequence');
    print(numberSequence);
    if(numberSequence!=null){
        _listSave[i].letter1 = listLetter[numberSequence<=100?0:numberSequence-100];
        _listSave[i].letter2 =  listLetter[(numberSequence / 100).round()];
        _listSave[i].cod = TextEditingController(text: '${_listSave[i].letter1}${_listSave[i].letter2}${numberSequence<10?0:''}$numberSequence - AA');
        db.collection('order').doc('codSequence').update({
          'letterFirst' : _listSave[i].letter1,
          'letterSecond' : _listSave[i].letter2,
          'numberSequence': numberSequence+1
        }).then((value) => setState(() {
          _listSave[i].codRep = true;
        }));
    }
  }
}

  @override
  void initState() {
    super.initState();
    if(widget.id==''){
      init();
    }else{
      dataEdit();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;

    return widget.id!=''?Scaffold(
      body: Flex(
              direction: Axis.horizontal,
              children: [
              Menu(index: 1),
                Flexible(
                  flex: 6,
                child: Container(
          height: heigth,
          width: width,
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
          child: loadingData
                ?Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 20),
                      Text('Coletando informações ...')
                    ],
                  )
                ):SingleChildScrollView(
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
                          height: 50.0,
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
                          height: 50.0,
                          controller: _controllerClientCod,
                          hint: '00000',
                          fonts: 14.0,
                          width: width * 0.05,
                          sizeIcon: 0.01,
                          icons: Icons.height,
                          colorBorder: PaletteColors.inputGrey,
                          background: PaletteColors.inputGrey,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value){
                            setState(() {
                              if(value != ''){
                                loadingCliente=true;
                                _dataClient(value.toString());
                              }else{
                                _controllerClientName = TextEditingController(text: '');
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        width: width * 0.25,
                        color: PaletteColors.inputGrey,
                        child: loadingCliente?Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              SizedBox(width: 50,height: 30),
                              SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator()
                              ),
                              SizedBox(width: 20),
                              Text('Procurando cliente. Aguarde ...',style: TextStyle(color: PaletteColors.primaryColor),)
                            ],
                          ),
                        ):InputRegister(
                          height: 50.0,
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
                              _controllerClientName.addListener(_searchClient);
                            });
                          },
                        ),
                      ),
                      Container(
                        width: width * 0.1,
                        child: InputRegister(
                          height: 50.0,
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
                  Container(
                    height: _listSave.length*60,
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: ListView.builder(
                        itemCount: _listSave.length,
                        itemBuilder: (context,index) {
                        return Row(
                          children: [
                            Container(
                              width: width * 0.06,
                              child: InputRegister(
                                controller: _listSave[index].cod,
                                hint: '0000',
                                fonts: 12.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.06,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value) {
                                  setState(() {
                                    if (value.toString() != '') {
                                      setState(() {
                                        indexGlobal = index;
                                        valuecodProd = value.toString();
                                        _listSave[index].cod = TextEditingController(text: value.toString());
                                      });
                                    } else {
                                      valuecodProd='';
                                    }
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.05,
                              margin: EdgeInsets.only(left: 3),
                              child: InputRegister(
                                controller: _listSave[index].ref,
                                hint: 'AAA',
                                fonts: 12.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.05,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    if (value.toString() != '') {
                                      setState(() {
                                        indexGlobal = index;
                                        valuecodProd = value.toString();
                                        _listSave[index].ref = TextEditingController(text: value.toString());
                                      });
                                    } else {
                                      valuecodProd='';
                                    }
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.035,
                              margin: EdgeInsets.only(left: 8),
                              child: InputRegister(
                                controller: _listSave[index].qtd,
                                hint: '00',
                                fonts: 12.0,
                                width: width * 0.035,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.05,
                              child: InputRegister(
                                controller: _listSave[index].maker,
                                hint: 'AAA',
                                fonts: 12.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.05,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.11,
                              child: InputRegister(
                                controller: _listSave[index].application,
                                hint: 'AAA',
                                fonts: 12.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.11,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.05,
                              child: InputRegister(
                                controller: _listSave[index].type,
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
                                      setState(() {
                                        indexGlobal=index;
                                      });
                                      valueProd =value.toString();
                                      resultSearchListProd('type');
                                    }else{
                                      _listSave[index].type = TextEditingController(text: '');
                                      valueProd='';
                                    }
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.04,
                              child: InputRegister(
                                controller: _listSave[index].comp,
                                hint: '0,00',
                                fonts: 12.0,
                                keyboardType: TextInputType.number,
                                width: width * 0.04,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.035,
                              child: InputRegister(
                                controller: _listSave[index].size,
                                hint: 'PP',
                                fonts: 12.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.035,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.045,
                              child: InputRegister(
                                controller: _listSave[index].term1,
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
                                        setState(() {
                                          indexGlobal=index;
                                        });
                                        valueProd =value.toString();
                                        resultSearchListProd('term1');
                                      }else{
                                        _listSave[index].term1 = TextEditingController(text: '');
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
                                controller: _listSave[index].term2,
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
                                        setState(() {
                                          indexGlobal=index;
                                        });
                                        valueProd =value.toString();
                                        resultSearchListProd('term2');
                                      }else{
                                        _listSave[index].term2 = TextEditingController(text: '');
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
                                controller: _listSave[index].case1,
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
                                        setState(() {
                                          indexGlobal=index;
                                        });
                                        valueProd =value.toString();
                                        resultSearchListProd('case');
                                      }else{
                                        _listSave[index].case1 = TextEditingController(text: '');
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
                                controller: _listSave[index].pos,
                                hint: '',
                                fonts: 12.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.032,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.045,
                              child: InputRegister(
                                controller: _listSave[index].adap1,
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
                                        setState(() {
                                          indexGlobal=index;
                                        });
                                        valueProd =value.toString();
                                        resultSearchListProd('adap1');
                                      }else{
                                        _listSave[index].adap1 = TextEditingController(text: '');
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
                                controller: _listSave[index].adap2,
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
                                        setState(() {
                                          indexGlobal=index;
                                        });
                                        valueProd =value.toString();
                                        resultSearchListProd('adap2');
                                      }else{
                                        _listSave[index].adap2 = TextEditingController(text: '');
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
                                enable: false,
                                controller: _listSave[index].anel,
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
                                controller: _listSave[index].mola,
                                hint: '',
                                fonts: 12.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.03,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      }
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
                                    title: Text('NUMERO ORIGINAL: ${item['numoriginal']},CÓDIGO: ${item['codprod']}, MARCA: ${item['marca']}, ESTOQUE 1: ${item['estf1']}, ESTOQUE 2: ${item['estf2']}, PREÇO: ${item['preco']}'),
                                    onTap: ()=>setState(() {
                                        if(_listSave[indexGlobal].term1.text.isNotEmpty && valueProd == _listSave[indexGlobal].term1.text){
                                          _listSave[indexGlobal].term1 = TextEditingController(text: item['numoriginal']);
                                          term1Price = item['preco'];
                                          term1Marca = item['marca'];
                                        }
                                        if(_listSave[indexGlobal].term2.text.isNotEmpty && valueProd == _listSave[indexGlobal].term2.text){
                                          _listSave[indexGlobal].term2 = TextEditingController(text: item['numoriginal']);
                                          term2Price = item['preco'];
                                          term2Marca = item['marca'];
                                        }
                                        if(_listSave[indexGlobal].case1.text.isNotEmpty && valueProd == _listSave[indexGlobal].case1.text){
                                          _listSave[indexGlobal].case1 = TextEditingController(text: item['numoriginal']);
                                          case1Price = item['preco'];
                                          case1Marca = item['marca'];
                                        }
                                        if(_listSave[indexGlobal].adap1.text.isNotEmpty && valueProd == _listSave[indexGlobal].adap1.text){
                                          _listSave[indexGlobal].adap1 = TextEditingController(text: item['numoriginal']);
                                          adap1Price = item['preco'];
                                          adap1Marca = item['marca'];
                                        }
                                        if(_listSave[indexGlobal].adap2.text.isNotEmpty && valueProd == _listSave[indexGlobal].adap2.text){
                                          _listSave[indexGlobal].adap2 = TextEditingController(text: item['numoriginal']);
                                          adap2Price = item['preco'];
                                          adap2Marca = item['marca'];
                                        }
                                        if(_listSave[indexGlobal].type.text.isNotEmpty && valueProd == _listSave[indexGlobal].type.text){
                                          _listSave[indexGlobal].type = TextEditingController(text: item['numoriginal']);
                                          typePrice = item['preco'];
                                          typeMarca = item['marca'];
                                          _listSave[indexGlobal].descricao = '${item['diametro']} ${item['pressao']} Fem GIR ${item['estf1']}° / Macho ${item['estf2']}°';
                                        }
                                        valueProd='';
                                        listProduct.add(
                                            SaveListProduct(
                                                numoriginal: item['numoriginal'],
                                                cod: item['codprod'],
                                                codUnico: _listSave[indexGlobal].cod.text,
                                                ref:  item['numoriginal'].toString(),
                                                qtd: _listSave[indexGlobal].qtd.text,
                                                fabricante: item['marca'],
                                                valorTabela: '${(double.parse(item['preco'])*int.parse(_listSave[indexGlobal].qtd.text)).toString().replaceAll('.', ',')}',
                                                desconto: TextEditingController(text: 'R\$ 0,00'),
                                                valorUnitario: TextEditingController(text: 'R\$ ${item['preco'].toString().replaceAll('.', ',')}'),
                                                total: 'R\$ ${(double.parse(item['preco'])*int.parse(_listSave[indexGlobal].qtd.text)).toString().replaceAll('.', ',')}',
                                            )
                                        );
                                      }
                                    ),
                                  );
                                }
                            );
                          }
                      )
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
                                setState(() {
                                  _addList();
                                });
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
                                 'cod#${_listSave[i].cod.text}#ref#${_listSave[i].ref.text}#qtd#${_listSave[i].qtd.text}#maker#${_listSave[i].maker.text}'
                                 '#aplication#${_listSave[i].application.text}#size#${_listSave[i].size.text}#comprimento#${_listSave[i].comp.text}'
                                 '#type#${_listSave[i].type.text}#typePrice#${_listSave[i].typePrice.length}#typeMarca#${_listSave[i].typeMarca}'
                                 '#term1#${_listSave[i].term1.text}#term1Price#${_listSave[i].term1Price}#term1Marca#${_listSave[i].term1Marca}'
                                 '#term2#${_listSave[i].term2.text}#term2Price#${_listSave[i].term2Price}#term2Marca#${_listSave[i].term2Marca}'
                                 '#capa#${_listSave[i].case1.text}#capaPrice#${_listSave[i].case1Price}#capa1Marca#${_listSave[i].case1Marca}'
                                 '#pos#${_listSave[i].pos.text}#adap1#${_listSave[i].adap1.text}#adap1Price#${_listSave[i].adap1Price}#adap1Marca#${_listSave[i].adap1Marca}'
                                 '#adap2#${_listSave[i].adap2.text}#adap2Price#${_listSave[i].adap2Price}#adap2Marca#${_listSave[i].adap2Marca}'
                                 '#anel#${_listSave[i].anel.text}#mola#${_listSave[i].mola.text}#descricao#${_listSave[i].descricao}'
                             );
                             insertList(i);
                            }
                            for(var i=0;listProduct.length>i;i++){
                              auxPrice.add(
                                  'cod#${listProduct[i].cod}#codUnico#${listProduct[i].codUnico}#ref#${listProduct[i].ref}#qtd#${listProduct[i].qtd}#'
                                  'fabricante#${listProduct[i].fabricante}#valorTabela#${listProduct[i].valorTabela}#desconto#${listProduct[i].desconto}#'
                                  'valorUnitario#${listProduct[i].valorUnitario}#total#${listProduct[i].total}'
                              );
                            }
                            if(aux.length != 0 ){
                              db.collection('assembly').doc(id).set({
                                'id':id,
                                'data':_controllerDate!=null?_controllerDate.text:'',
                                'codcli':_controllerClientCod!=null?_controllerClientCod.text:'',
                                'cliente':_controllerClientName!=null?_controllerClientName.text:'',
                                'filial':_controllerAffiliation!=null?_controllerAffiliation.text:'',
                                'produtos':aux.toList(),
                                'prodPrecos':auxPrice.toList(),
                                'dateOrder':DateTime.now(),
                                'status': TextConst.aguardando,
                                'order': order.toString(),
                                'priority': '1 - Cliente Balcão'
                              }).then((value){
                                db.collection('order').doc('order').update({
                                'order':int.parse(order.toString())
                                }).then((value) =>
                                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new
                                      PriceScreen(
                                        saveListModel: _listSave,saveListProduct: listProduct,idAssembly: id,
                                        client: _controllerClientName.text,codClient: _controllerClientCod.text,
                                        order: order.toString(),data: _controllerDate.text,filial: _controllerAffiliation.text,
                                      )
                                    ))
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
        ),
              ),
            ]
      ),
    ):Container(
      height: heigth,
      width: width,
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
      child: loadingData
          ?Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Coletando informações ...')
            ],
          )
      ):SingleChildScrollView(
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
                    height: 50.0,
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
                    height: 50.0,
                    controller: _controllerClientCod,
                    hint: '00000',
                    fonts: 14.0,
                    width: width * 0.05,
                    sizeIcon: 0.01,
                    icons: Icons.height,
                    colorBorder: PaletteColors.inputGrey,
                    background: PaletteColors.inputGrey,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value){
                      setState(() {
                        if(value != ''){
                          loadingCliente=true;
                          _dataClient(value.toString());
                        }else{
                          _controllerClientName = TextEditingController(text: '');
                        }
                      });
                    },
                  ),
                ),
                Container(
                  height: 50,
                  width: width * 0.25,
                  color: PaletteColors.inputGrey,
                  child: loadingCliente?Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        SizedBox(width: 50,height: 30),
                        SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator()
                        ),
                        SizedBox(width: 20),
                        Text('Procurando cliente. Aguarde ...',style: TextStyle(color: PaletteColors.primaryColor),)
                      ],
                    ),
                  ):InputRegister(
                    height: 50.0,
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
                        _controllerClientName.addListener(_searchClient);
                      });
                    },
                  ),
                ),
                Container(
                  width: width * 0.1,
                  child: InputRegister(
                    height: 50.0,
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
            Container(
              height: _listSave.length*60,
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ListView.builder(
                  itemCount: _listSave.length,
                  itemBuilder: (context,index) {
                    return Container(
                      color: _listSave[index].selected?PaletteColors.primaryColor:PaletteColors.white,
                      child: ListTile(
                        onTap: (){
                          setState(() {
                            _listSave[index].selected? _listSave[index].selected=false : _listSave[index].selected=true;
                            _listSave[index].selected?indexDuplicate = index:indexDuplicate=null;
                          });
                        },
                        title: Row(
                          children: [
                            Container(
                              width: width * 0.06,
                              child: InputRegister(
                                controller: _listSave[index].cod,
                                hint: '0000',
                                fonts: 12.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.06,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                    valuecodProd = value.toString();
                                    resultSearchListRef();
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.05,
                              margin: EdgeInsets.only(left: 3),
                              child: InputRegister(
                                controller: _listSave[index].ref,
                                hint: 'AAA',
                                fonts: 12.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.05,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    if (value.toString() != '') {
                                      setState(() {
                                        indexGlobal = index;
                                        valuecodProd = value.toString();
                                        _listSave[index].ref = TextEditingController(text: value.toString());
                                      });
                                    } else {
                                      valuecodProd='';
                                    }
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.035,
                              margin: EdgeInsets.only(left: 8),
                              child: InputRegister(
                                controller: _listSave[index].qtd,
                                hint: '00',
                                fonts: 12.0,
                                width: width * 0.035,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.05,
                              child: InputRegister(
                                controller: _listSave[index].maker,
                                hint: 'AAA',
                                fonts: 12.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.05,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.11,
                              child: InputRegister(
                                controller: _listSave[index].application,
                                hint: 'AAA',
                                fonts: 12.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.11,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.05,
                              child: InputRegister(
                                controller: _listSave[index].type,
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
                                      setState(() {
                                        indexGlobal=index;
                                      });
                                      valueProd =value.toString();
                                      resultSearchListProd('type');
                                    }else{
                                      _listSave[index].type = TextEditingController(text: '');
                                      valueProd='';
                                    }
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.04,
                              child: InputRegister(
                                controller: _listSave[index].comp,
                                hint: '0,00',
                                fonts: 12.0,
                                keyboardType: TextInputType.number,
                                width: width * 0.04,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.035,
                              child: InputRegister(
                                controller: _listSave[index].size,
                                hint: 'PP',
                                fonts: 12.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.035,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.045,
                              child: InputRegister(
                                controller: _listSave[index].term1,
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
                                        setState(() {
                                          indexGlobal=index;
                                        });
                                        valueProd =value.toString();
                                        resultSearchListProd('term1');
                                      }else{
                                        _listSave[index].term1 = TextEditingController(text: '');
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
                                controller: _listSave[index].term2,
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
                                        setState(() {
                                          indexGlobal=index;
                                        });
                                        valueProd =value.toString();
                                        resultSearchListProd('term2');
                                      }else{
                                        _listSave[index].term2 = TextEditingController(text: '');
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
                                controller: _listSave[index].case1,
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
                                        setState(() {
                                          indexGlobal=index;
                                        });
                                        valueProd =value.toString();
                                        resultSearchListProd('case');
                                      }else{
                                        _listSave[index].case1 = TextEditingController(text: '');
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
                                controller: _listSave[index].pos,
                                hint: '',
                                fonts: 12.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.032,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.045,
                              child: InputRegister(
                                controller: _listSave[index].adap1,
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
                                        setState(() {
                                          indexGlobal=index;
                                        });
                                        valueProd =value.toString();
                                        resultSearchListProd('adap1');
                                      }else{
                                        _listSave[index].adap1 = TextEditingController(text: '');
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
                                controller: _listSave[index].adap2,
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
                                        setState(() {
                                          indexGlobal=index;
                                        });
                                        valueProd =value.toString();
                                        resultSearchListProd('adap2');
                                      }else{
                                        _listSave[index].adap2 = TextEditingController(text: '');
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
                                controller: _listSave[index].anel,
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
                                controller: _listSave[index].mola,
                                hint: '',
                                fonts: 12.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.03,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (value){
                                  setState(() {
                                    indexGlobal=index;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
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
                              title: Text('NUMERO ORIGINAL: ${item['numoriginal']},CÓDIGO: ${item['codprod']}, MARCA: ${item['marca']}, ESTOQUE 1: ${item['estf1']}, ESTOQUE 2: ${item['estf2']}, PREÇO: ${item['preco']}'),
                              onTap: ()=>setState(() {
                                if(_listSave[indexGlobal].term1.text.isNotEmpty && valueProd == _listSave[indexGlobal].term1.text){
                                  _listSave[indexGlobal].term1 = TextEditingController(text: item['numoriginal']);
                                  term1Price = item['preco'];
                                  term1Marca = item['marca'];
                                  _listSave[indexGlobal].anel = TextEditingController(text: item['codoring']!='null'?'X':'');
                                }
                                if(_listSave[indexGlobal].term2.text.isNotEmpty && valueProd == _listSave[indexGlobal].term2.text){
                                  _listSave[indexGlobal].term2 = TextEditingController(text: item['numoriginal']);
                                  term2Price = item['preco'];
                                  term2Marca = item['marca'];
                                  _listSave[indexGlobal].anel = TextEditingController(text: item['codoring']!='null'?'X':'');
                                }
                                if(_listSave[indexGlobal].case1.text.isNotEmpty && valueProd == _listSave[indexGlobal].case1.text){
                                  _listSave[indexGlobal].case1 = TextEditingController(text: item['numoriginal']);
                                  case1Price = (double.parse(item['preco'])*2).toString();
                                  case1Marca = item['marca'];
                                }
                                if(_listSave[indexGlobal].adap1.text.isNotEmpty && valueProd == _listSave[indexGlobal].adap1.text){
                                  _listSave[indexGlobal].adap1 = TextEditingController(text: item['numoriginal']);
                                  adap1Price = item['preco'];
                                  adap1Marca = item['marca'];
                                }
                                if(_listSave[indexGlobal].adap2.text.isNotEmpty && valueProd == _listSave[indexGlobal].adap2.text){
                                  _listSave[indexGlobal].adap2 = TextEditingController(text: item['numoriginal']);
                                  adap2Price = item['preco'];
                                  adap2Marca = item['marca'];
                                }
                                if(_listSave[indexGlobal].type.text.isNotEmpty && valueProd == _listSave[indexGlobal].type.text){
                                  _listSave[indexGlobal].type = TextEditingController(text: item['numoriginal']);
                                  typePrice = item['preco'];
                                  typeMarca = item['marca'];
                                  _listSave[indexGlobal].descricao = '${item['diametro']} ${item['pressao']} Fem GIR ${item['estf1']}° / Macho ${item['estf2']}°';
                                }
                                valueProd='';
                                listProduct.add(
                                    SaveListProduct(
                                      numoriginal: item['numoriginal'],
                                      cod: item['codprod'],
                                      codUnico: _listSave[indexGlobal].cod.text,
                                      ref:  item['numoriginal'].toString(),
                                      qtd: _listSave[indexGlobal].qtd.text,
                                      fabricante: item['marca'],
                                      valorTabela: '${(double.parse(item['preco'])*int.parse(_listSave[indexGlobal].qtd.text)).toString().replaceAll('.', ',')}',
                                      desconto: TextEditingController(text: 'R\$ 0,00'),
                                      valorUnitario: TextEditingController(text: 'R\$ ${item['preco'].toString().replaceAll('.', ',')}'),
                                      total: 'R\$ ${(double.parse(item['preco'])*int.parse(_listSave[indexGlobal].qtd.text)).toString().replaceAll('.', ',')}',
                                    )
                                );
                              }
                              ),
                            );
                          }
                      );
                    }
                )
            ):Container(),
            valuecodProd!='' && _resultsCodUnico.length!=0? Container(
                height: heigth*0.3,
                child: StreamBuilder<QuerySnapshot>(
                    stream: _controllerItems.stream,
                    builder: (context,snapshot){
                      return ListView.builder(
                          itemCount: _resultsCodUnico.length,
                          itemBuilder: (contect,index){
                            DocumentSnapshot item = _resultsCodUnico[index];

                            return ListTile(
                              title: Text('Cód. Unico: ${item['codUnico']}, Referência: ${item['ref']}, Mangueira: ${item['type']}, Term1: ${item['term1']}, Term2: ${item['term2']}, Capa: ${item['case1']}, POS: ${item['pos']}'),
                              onTap: ()=>setState(() {
                                  _listSave[indexGlobal].cod = TextEditingController(text: item['codUnico']);
                                  _listSave[indexGlobal].case1 = TextEditingController(text: item['case1']);
                                  case1Price = item['case1Price'];
                                  case1Marca = item['case1Marca'];
                                  _listSave[indexGlobal].pos = TextEditingController(text: item['pos']);
                                  _listSave[indexGlobal].ref = TextEditingController(text: item['ref']);
                                  _listSave[indexGlobal].term1 = TextEditingController(text: item['term1']);
                                  term1Price = item['term1Price'];
                                  term1Marca = item['term1Marca'];
                                  _listSave[indexGlobal].term2 = TextEditingController(text: item['term2']);
                                  term2Price = item['term2Price'];
                                  term2Marca = item['term2Marca'];
                                  _listSave[indexGlobal].type = TextEditingController(text: item['type']);
                                  typePrice = item['typePrice'];
                                  typeMarca = item['typeMarca'];
                                  valuecodProd='';
                                  _listSave[indexGlobal].codRep = true;
                                  sequenceUpdate(_listSave[indexGlobal].cod.text,true,0);
                              }
                              ),
                            );
                          }
                      );
                    }
                )
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
                            setState(() {
                              _addList();
                            });
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
                      onPressed: () {
                        if(indexDuplicate!=null){
                          setState(() {

                            var _controllerCodProduct = TextEditingController(text: _listSave[indexDuplicate!].cod.text);
                            var _controllerRef = TextEditingController(text: _listSave[indexDuplicate!].ref.text);
                            var _controllerQtd = TextEditingController(text: _listSave[indexDuplicate!].qtd.text);
                            var _controllerMaker = TextEditingController(text: _listSave[indexDuplicate!].maker.text);
                            var _controllerAplication = TextEditingController(text: _listSave[indexDuplicate!].application.text);
                            var _controllerSize = TextEditingController(text: _listSave[indexDuplicate!].size.text);
                            var _controllerComp = TextEditingController(text: _listSave[indexDuplicate!].comp.text);
                            var _controllerType = TextEditingController(text: _listSave[indexDuplicate!].type.text);
                            var _controllerTerm1 = TextEditingController(text: _listSave[indexDuplicate!].term1.text);
                            var _controllerTerm2 = TextEditingController(text: _listSave[indexDuplicate!].term2.text);
                            var _controllerCase = TextEditingController(text: _listSave[indexDuplicate!].case1.text);
                            var _controllerPos = TextEditingController(text: _listSave[indexDuplicate!].pos.text);
                            var _controllerAdap1 = TextEditingController(text: _listSave[indexDuplicate!].adap1.text);
                            var _controllerAdap2 = TextEditingController(text: _listSave[indexDuplicate!].adap2.text);
                            var _controllerAN = TextEditingController(text: _listSave[indexDuplicate!].anel.text);
                            var _controllerMO = TextEditingController(text: _listSave[indexDuplicate!].mola.text);
                            var typePrice = _listSave[indexDuplicate!].typePrice;
                            var typeMarca = _listSave[indexDuplicate!].typeMarca;
                            var term1Price = _listSave[indexDuplicate!].term1Price;
                            var term1Marca = _listSave[indexDuplicate!].term1Marca;
                            var term2Price = _listSave[indexDuplicate!].term2Price;
                            var term2Marca = _listSave[indexDuplicate!].term2Marca;
                            var case1Price = _listSave[indexDuplicate!].case1Price;
                            var case1Marca = _listSave[indexDuplicate!].case1Marca;
                            var adap1Price = _listSave[indexDuplicate!].adap1Price;
                            var adap1Marca = _listSave[indexDuplicate!].adap1Marca;
                            var adap2Price = _listSave[indexDuplicate!].adap2Price;
                            var adap2Marca = _listSave[indexDuplicate!].adap2Marca;

                            _listSave.add(
                                SaveListModel(
                                  cod: _controllerCodProduct,
                                  ref: _controllerRef,
                                  qtd: _controllerQtd,
                                  maker: _controllerMaker,
                                  application: _controllerAplication,
                                  size:_controllerSize,
                                  comp:_controllerComp,
                                  type:_controllerType,
                                  typePrice: typePrice,
                                  typeMarca: typeMarca,
                                  term1: _controllerTerm1,
                                  term1Price: term1Price,
                                  term1Marca: term1Marca,
                                  term2: _controllerTerm2,
                                  term2Price: term2Price,
                                  term2Marca: term2Marca,
                                  case1: _controllerCase,
                                  case1Price: case1Price,
                                  case1Marca: case1Marca,
                                  pos: _controllerPos,
                                  adap1: _controllerAdap1,
                                  adap1Price: adap1Price,
                                  adap1Marca: adap1Marca,
                                  adap2: _controllerAdap2,
                                  adap2Price: adap2Price,
                                  adap2Marca: adap2Marca,
                                  anel: _controllerAN,
                                  mola: _controllerMO,
                                  valorTabela: 'R\$ 00,00',
                                  desconto: TextEditingController(text: '0'),
                                  valorUnitario: TextEditingController(text: 'R\$ 00,00'),
                                  total:'R\$ 00,00',
                                  descricao: '',
                                )
                            );
                          });
                          indexDuplicate=null;
                        }
                      },
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
                    onPressed: ()async {
                      List aux = [];
                      List auxPrice = [];
                      for(var i=0;_listSave.length>i;i++){
                        if(_listSave[i].cod.text.isEmpty){
                          Future.delayed(Duration(seconds: 2),(){
                            sequenceUpdate('',false,i);
                          });
                        }
                        aux.add(
                            'cod#${_listSave[i].cod.text}#ref#${_listSave[i].ref.text}#qtd#${_listSave[i].qtd.text}#maker#${_listSave[i].maker.text}'
                                '#aplication#${_listSave[i].application.text}#numoriginal#${_listSave[i].type.text}#comprimento#${_listSave[i].comp.text}'
                                '#type#${_listSave[i].size.text}#typePrice#${_listSave[i].typePrice.length}#typeMarca#${_listSave[i].typeMarca}'
                                '#term1#${_listSave[i].term1.text}#term1Price#${_listSave[i].term1Price}#term1Marca#${_listSave[i].term1Marca}'
                                '#term2#${_listSave[i].term2.text}#term2Price#${_listSave[i].term2Price}#term2Marca#${_listSave[i].term2Marca}'
                                '#capa#${_listSave[i].case1.text}#capaPrice#${_listSave[i].case1Price}#capa1Marca#${_listSave[i].case1Marca}'
                                '#pos#${_listSave[i].pos.text}#adap1#${_listSave[i].adap1.text}#adap1Price#${_listSave[i].adap1Price}#adap1Marca#${_listSave[i].adap1Marca}'
                                '#adap2#${_listSave[i].adap2.text}#adap2Price#${_listSave[i].adap2Price}#adap2Marca#${_listSave[i].adap2Marca}'
                                '#anel#${_listSave[i].anel.text}#mola#${_listSave[i].mola.text}#descricao#${_listSave[i].descricao}'
                        );
                        insertList(i);
                        if(_listSave[i].cod.text!=''){
                          FirebaseFirestore.instance.collection('codUnico').doc(_listSave[i].cod.text).set({
                            'codUnico' : _listSave[i].cod.text,
                            'ref' : _listSave[i].ref.text,
                            'type': _listSave[i].type.text,
                            'typePrice': _listSave[i].typePrice,
                            'typeMarca': _listSave[i].typeMarca,
                            'term1': _listSave[i].term1.text,
                            'term1Price': _listSave[i].term1Price,
                            'term1Marca': _listSave[i].term1Marca,
                            'term2': _listSave[i].term2.text,
                            'term2Price': _listSave[i].term2Price,
                            'term2Marca': _listSave[i].term2Marca,
                            'case1': _listSave[i].case1.text,
                            'case1Price': _listSave[i].case1Price,
                            'case1Marca': _listSave[i].case1Marca,
                            'pos': _listSave[i].pos.text,
                          });
                        }
                      }
                      for(var i=0;listProduct.length>i;i++){
                        auxPrice.add(
                            'cod#${listProduct[i].cod}#codUnico#${listProduct[i].codUnico}#ref#${listProduct[i].ref}#qtd#${listProduct[i].qtd}#'
                                'fabricante#${listProduct[i].fabricante}#valorTabela#${listProduct[i].valorTabela}#desconto#${listProduct[i].desconto.text}#'
                                'valorUnitario#${listProduct[i].valorUnitario.text}#total#${listProduct[i].total}'
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
                          'dateOrder':DateTime.now(),
                          'status': TextConst.aguardando,
                          'order': order.toString(),
                          'priority': '1 - Cliente Balcão'
                        }).then((value){
                          db.collection('order').doc('order').update({
                            'order':int.parse(order.toString())
                          }).then((value) =>
                              Navigator.push(context, new MaterialPageRoute(builder: (context) => new
                              PriceScreen(
                                saveListModel: _listSave,saveListProduct: listProduct,idAssembly: id,
                                client: _controllerClientName.text,codClient: _controllerClientCod.text,
                                order: order.toString(),data: _controllerDate.text,filial: _controllerAffiliation.text,
                              )
                              ))
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
