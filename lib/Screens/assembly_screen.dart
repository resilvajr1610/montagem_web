import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:montagem_web/Models/error_int_model.dart';
import 'package:montagem_web/Models/assembly_list_model.dart';
import 'package:montagem_web/Models/product_list_model.dart';
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
  List<AssemblyListModel> _listAssembly = [];
  List<ProductListModel> _listProduct = [];
  String valueClient = '';
  String valueProd = '';
  String valuecodProd = '';
  int indexGlobal = 0;
  int? indexDuplicate;
  String id = '';
  bool loadingCliente = false;
  bool loadingData = true;
  int order = 0;
  List listLetter = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','Y','Z'];
  String selectedPriority='1 - Cliente Balcão';
  String whinthor = '';
  String status = '';

  _getOrder() async {
    DocumentSnapshot snapshot = await db.collection('order').doc('order').get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    setState(() {
      order = data?["order"] ?? 0;
      order = order + 1;
    });
  }

  _dataClient(String codcli) async {
    DocumentSnapshot snapshot =
        await db.collection("clientes").doc(codcli).get();
    Map<String, dynamic>? dataMap = snapshot.data() as Map<String, dynamic>?;
    setState(() {
      _controllerClientName = TextEditingController(text: dataMap?['cliente']);
      loadingCliente = false;
    });
  }

  _dataSearchProd() async {
    var data = await db.collection("produtos").get();
    setState(() {
      _allResultsProd = data.docs;
      loadingData = false;
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
      loadingData = false;
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

    if (_listAssembly[indexGlobal].cod.text.isNotEmpty) {
      for (var items in _allResultsCodUnico) {
        var item = SearchCodUnicoModel.fromSnapshot(items).name.toUpperCase();

        if (item.startsWith(_listAssembly[indexGlobal].cod.text.toUpperCase())) {
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

    if (_listAssembly[indexGlobal].ref.text.isNotEmpty) {
      for (var items in _allResultsCodUnico) {
        var item = SearchRefModel.fromSnapshot(items).name.toUpperCase();

        if (item.startsWith(_listAssembly[indexGlobal].ref.text.toUpperCase())) {
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

    if (_listAssembly[indexGlobal].term1.text != "" && type == 'term1') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.startsWith(_listAssembly[indexGlobal].term1.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    } else if (_listAssembly[indexGlobal].term2.text != "" && type == 'term2') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.startsWith(_listAssembly[indexGlobal].term2.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    } else if (_listAssembly[indexGlobal].cape.text != "" && type == 'case') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.startsWith(_listAssembly[indexGlobal].cape.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    } else if (_listAssembly[indexGlobal].adap1.text != "" && type == 'adap1') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.startsWith(_listAssembly[indexGlobal].adap1.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    } else if (_listAssembly[indexGlobal].adap2.text != "" && type == 'adap2') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item.startsWith(_listAssembly[indexGlobal].adap2.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    } else if (_listAssembly[indexGlobal].hose.text != "" && type == 'hose') {
      for (var items in _allResultsProd) {
        var item = SearchProdModel.fromSnapshot(items).name.toLowerCase();

        if (item
            .startsWith(_listAssembly[indexGlobal].hose.text.toLowerCase())) {
          showResults.add(items);
        }
      }
    } else {
      showResults = List.from(_allResultsProd);
    }
    setState(() {
      _resultsProd = showResults;
    });
  }

  createId() {
    CollectionReference create = db.collection("assembly");
    setState(() {
      id = create.doc().id;
      _controllerDate = TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
    });
  }

  insertList(int index) {
    double totalTabela = 0;
    double uni = 0;

    totalTabela = (double.parse(_listAssembly[index].hosePrice) + double.parse(_listAssembly[index].term1Price) +double.parse(_listAssembly[index].term2Price)
        +double.parse(_listAssembly[index].capePrice) +double.parse(_listAssembly[index].adap1Price) +double.parse(_listAssembly[index].adap2Price)) *int.parse(_listAssembly[index].qtd.text);
    uni = totalTabela / int.parse(_listAssembly[index].qtd.text);
    setState(() {
      _listAssembly[index].valueTable ='R\$ ${totalTabela.toStringAsFixed(2).replaceAll('.', ',')}';
      _listAssembly[index].valueUnit.text ='R\$ ${uni.toStringAsFixed(2).replaceAll('.', ',')}';
      _listAssembly[index].total ='R\$ ${totalTabela.toStringAsFixed(2).replaceAll('.', ',')}';
      totalTabela = 0;
      uni = 0;
    });
  }

  _addList() {
    var _controllerCodProduct = TextEditingController();
    var _controllerRef = TextEditingController();
    var _controllerQtd = TextEditingController(text: '1');
    var _controllerMaker = TextEditingController();
    var _controllerAplication = TextEditingController();
    var _controllerSize = TextEditingController();
    var _controllerComp = TextEditingController();
    var _controllerHose = TextEditingController();
    var _controllerTerm1 = TextEditingController();
    var _controllerTerm2 = TextEditingController();
    var _controllerCase = TextEditingController();
    var _controllerPos = TextEditingController();
    var _controllerAdap1 = TextEditingController();
    var _controllerAdap2 = TextEditingController();
    var _controllerAN = TextEditingController();
    var _controllerMO = TextEditingController();
    setState(() {
      _listAssembly.add(AssemblyListModel(
        cod: _controllerCodProduct,
        ref: _controllerRef,
        qtd: _controllerQtd,
        maker: _controllerMaker,
        application: _controllerAplication,
        size: _controllerSize,
        comp: _controllerComp,
        hose: _controllerHose,
        hosePrice: '0.0',
        hoseBrand: '',
        hoseQtd: 1.0,
        term1: _controllerTerm1,
        term1Price: '0.0',
        term1Brand: '',
        term1Qtd: 1.0,
        term2: _controllerTerm2,
        term2Price: '0.0',
        term2Brand: '',
        term2Qtd: 1.0,
        cape: _controllerCase,
        capePrice: '0.0',
        capeBrand: '',
        capeQtd: 2.0,
        pos: _controllerPos,
        adap1: _controllerAdap1,
        adap1Price: '0.0',
        adap1Brand: '',
        adap1Qtd: 1.0,
        adap2: _controllerAdap2,
        adap2Price: '0.0',
        adap2Brand: '',
        adap2Qtd: 1.0,
        ring: _controllerAN,
        ringQtd: 1.0,
        spring: _controllerMO,
        springQtd: 1.0,
        valueTable: 'R\$ 00,00',
        discount: TextEditingController(text: '0'),
        valueUnit: TextEditingController(text: 'R\$ 00,00'),
        total: 'R\$ 00,00',
        diameterHose: '',
        pressureHose: '',
        descTerm1: '',
        descTerm2: '',
      ));
    });
  }

  dataEdit() async {
    DocumentSnapshot snapshot = await db.collection("assembly").doc(widget.id).get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    setState(() {
      _controllerClientCod = TextEditingController(text: data?['codcli'] ?? '');
      _controllerClientName = TextEditingController(text: data?['client'] ?? '');
      _controllerDate = TextEditingController(text: data?['data'] ?? '');
      _controllerAffiliation = TextEditingController(text: data?['subsidiary'] ?? '');
      selectedPriority = data?['priority']??'1 - Cliente Balcão';
      whinthor =data?['whinthor']??'0';
      status = data?['status']??TextConst.aguardando;
      id = data?['id'];
      order = int.parse(data?['order']);

      List codAssembly          = data?['codAssembly']??[];
      List refAssembly          = data?['refAssembly']??[];
      List qtdAssembly          = data?['qtdAssembly']??[];
      List hoseAssembly         = data?['hoseAssembly']??[];
      List sizeAssembly         = data?['sizeAssembly']??[];
      List lengthAssembly       = data?['lengthAssembly']??[];
      List term1Assembly        = data?['term1Assembly']??[];
      List term2Assembly        = data?['term2Assembly']??[];
      List capeAssembly         = data?['capeAssembly']??[];
      List adap1Assembly        = data?['adap1Assembly']??[];
      List adap2Assembly        = data?['adap2Assembly']??[];
      List ringAssembly         = data?['ringAssembly']??[];
      List springAssembly       = data?['springAssembly']??[];
      List makerAssembly        = data?['makerAssembly']??[];
      List apliAssembly         = data?['apliAssembly']??[];
      List pos                  = data?['pos']??[];
      List hoseBrandAssembly    = data?['hoseBrandAssembly']??[];
      List hosePriceAssembly    = data?['hosePriceAssembly']??[];
      List term1PriceAssembly   = data?['term1PriceAssembly']??[];
      List term1BrandAssembly   = data?['term1BrandAssembly']??[];
      List term2PriceAssembly   = data?['term2PriceAssembly']??[];
      List term2BrandAssembly   = data?['term2BrandAssembly']??[];
      List capePriceAssembly    = data?['capePriceAssembly']??[];
      List capeBrandAssembly    = data?['capeBrandAssembly']??[];
      List adap1PriceAssembly   = data?['adap1PriceAssembly']??[];
      List adap1BrandAssembly   = data?['adap1BrandAssembly']??[];
      List adap2PriceAssembly   = data?['adap2PriceAssembly']??[];
      List adap2BrandAssembly   = data?['adap2BrandAssembly']??[];
      List diameterHoseAssembly = data?['diameterHoseAssembly']??[];
      List pressureHoseAssembly = data?['pressureHoseAssembly']??[];
      List descTerm1Assembly    = data?['descTerm1Assembly']??[];
      List descTer21Assembly    = data?['descTer21Assembly']??[];

      for (var i = 0; codAssembly.length > i; i++) {

        var splitedCod        = codAssembly[i].toString().split('#');
        var splitedRef        = refAssembly[i].toString().split('#');
        var splitedQtd        = qtdAssembly[i].toString().split('#');
        var splitedHose       = hoseAssembly[i].toString().split('#');
        var splitedLength     = lengthAssembly[i].toString().split('#');
        var splitedSize       = sizeAssembly[i].toString().split('#');
        var splitedTerm1      = term1Assembly[i].toString().split('#');
        var splitedTerm2      = term2Assembly[i].toString().split('#');
        var splitedCape       = capeAssembly[i].toString().split('#');
        var splitedAdap1      = adap1Assembly[i].toString().split('#');
        var splitedAdap2      = adap2Assembly[i].toString().split('#');
        var splitedRing       = ringAssembly[i].toString().split('#');
        var splitedSpring     = springAssembly[i].toString().split('#');
        var splitedMaker      = makerAssembly[i].toString().split('#');
        var splitedApli       = apliAssembly[i].toString().split('#');
        var splitedPos        = pos[i].toString().split('#');
        var splitedHoseBrand  = hoseBrandAssembly[i].toString().split('#');
        var splitedHosePrice  = hosePriceAssembly[i].toString().split('#');
        var splitedTerm1Price = term1PriceAssembly[i].toString().split('#');
        var splitedTerm1Brand = term1BrandAssembly[i].toString().split('#');
        var splitedTerm2Price = term2PriceAssembly[i].toString().split('#');
        var splitedTerm2Brand = term2BrandAssembly[i].toString().split('#');
        var splitedCapePrice  = capePriceAssembly[i].toString().split('#');
        var splitedCapeBrand  = capeBrandAssembly[i].toString().split('#');
        var splitedAdap1Price = adap1PriceAssembly[i].toString().split('#');
        var splitedAdap1Brand = adap1BrandAssembly[i].toString().split('#');
        var splitedAdap2Price = adap2PriceAssembly[i].toString().split('#');
        var splitedAdap2Brand = adap2BrandAssembly[i].toString().split('#');
        var splitedDiameter   = diameterHoseAssembly[i].toString().split('#');
        var splitedPressure   = pressureHoseAssembly[i].toString().split('#');
        var splitedDescTerm1  = descTerm1Assembly[i].toString().split('#');
        var splitedDescTerm2  = descTer21Assembly[i].toString().split('#');

        var _controllerCodProduct = TextEditingController(text: splitedCod[1]);
        var _controllerRef        = TextEditingController(text: splitedRef[1]);
        var _controllerQtd        = TextEditingController(text: splitedQtd[1]);
        var _controllerMaker      = TextEditingController(text: splitedMaker[1]);
        var _controllerAplication = TextEditingController(text: splitedApli[1]);
        var _controllerSize       = TextEditingController(text: splitedSize[1]);
        var _controllerComp       = TextEditingController(text: splitedLength[1]);
        var _controllerHose       = TextEditingController(text: splitedHose[1]);
        var hosePrice             = splitedHosePrice[1];
        var hoseBrand             = splitedHoseBrand[1];
        var _controllerTerm1      = TextEditingController(text: splitedTerm1[1]);
        var term1P                = splitedTerm1Price[1];
        var term1Fab              = splitedTerm1Brand[1];
        var _controllerTerm2      = TextEditingController(text: splitedTerm2[1]);
        var term2P                = splitedTerm2Price[1];
        var term2Fab              = splitedTerm2Brand[1];
        var _controllerCape       = TextEditingController(text: splitedCape[1]);
        var caseP                 = splitedCapePrice[1];
        var caseFab               = splitedCapeBrand[1];
        var _controllerPos        = TextEditingController(text: splitedPos[1]);
        var _controllerAdap1      = TextEditingController(text: splitedAdap1[1]);
        var adap1P                = splitedAdap1Price[1];
        var adap1Fab              = splitedAdap1Brand[1];
        var _controllerAdap2      = TextEditingController(text: splitedAdap2[1]);
        var adap2P                = splitedAdap2Price[1];
        var adap2Fab              = splitedAdap2Brand[1];
        var _controllerRing       = TextEditingController(text: splitedRing[1]);
        var _controllerSpring     = TextEditingController(text: splitedSpring[1]);
        var diameterHose          = splitedDiameter[1];
        var pressureHose          = splitedPressure[1];
        var descricaoTerm1        = splitedDescTerm1[1];
        var descricaoTerm2        = splitedDescTerm2[1];

        _listAssembly.add(AssemblyListModel(
          cod: _controllerCodProduct,
          ref: _controllerRef,
          qtd: _controllerQtd,
          maker: _controllerMaker,
          application: _controllerAplication,
          size: _controllerSize,
          comp: _controllerComp,
          hose: _controllerHose,
          hosePrice: hosePrice,
          hoseBrand: hoseBrand,
          hoseQtd: int.parse(_controllerQtd.text) * 1.0,
          term1: _controllerTerm1,
          term1Price: term1P,
          term1Brand: term1Fab,
          term1Qtd: int.parse(_controllerQtd.text) * 1.0,
          term2: _controllerTerm2,
          term2Price: term2P,
          term2Brand: term2Fab,
          term2Qtd: int.parse(_controllerQtd.text) * 1.0,
          cape: _controllerCape,
          capePrice: caseP,
          capeBrand: caseFab,
          capeQtd: int.parse(_controllerQtd.text) * 2.0,
          pos: _controllerPos,
          adap1: _controllerAdap1,
          adap1Price: adap1P,
          adap1Brand: adap1Fab,
          adap1Qtd: int.parse(_controllerQtd.text) * 1.0,
          adap2: _controllerAdap2,
          adap2Price: adap2P,
          adap2Brand: adap2Fab,
          adap2Qtd: int.parse(_controllerQtd.text) * 1.0,
          ring: _controllerRing,
          ringQtd: int.parse(_controllerQtd.text) * 1.0,
          spring: _controllerSpring,
          springQtd: int.parse(_controllerQtd.text) * 1.0,
          valueTable: '0',
          discount: TextEditingController(text: '0'),
          valueUnit: TextEditingController(text: '0'),
          total: '0',
          diameterHose: diameterHose,
          pressureHose: pressureHose,
          descTerm1: descricaoTerm1,
          descTerm2: descricaoTerm2,
        ));

        List codProd        = data?['codProd$i']??[];
        List refProd        = data?['refProd$i']??[];
        List qtdProd        = data?['qtdProd$i']??[];
        List fabProd        = data?['fabProd$i']??[];
        List valueTableProd = data?['valueTableProd$i']??[];
        List totalProd      = data?['totalProd$i']??[];
        List itemProd       = data?['itemProd$i']??[];
        List inputProd      = data?['inputProd$i']??[];
        List discountProd   = data?['discountProd$i']??[];
        List valueUnitProd  = data?['valueUnitProd$i']??[];

        for (var index = 0; codProd.length > index; index++) {
          var splitedCod        = codProd[index].toString().split('#');
          var splitedUnit       = codProd[index].toString().split('#');
          var splitedRef        = refProd[index].toString().split('#');
          var splitedQtd        = qtdProd[index].toString().split('#');
          var splitedFab        = fabProd[index].toString().split('#');
          var splitedValueTable = valueTableProd[index].toString().split('#');
          var splitedTotal      = totalProd[index].toString().split('#');
          var splitedItem       = itemProd[index].toString().split('#');
          var splitedInput      = inputProd[index].toString().split('#');
          var splitedDiscount   = discountProd[index].toString().split('#');
          var splitedValueUnit  = valueUnitProd[index].toString().split('#');
          var controllerValueUnit = TextEditingController(text: splitedValueUnit[1]);
          var controllerDiscount = TextEditingController(text: splitedDiscount[1]);

          _listProduct.add(
              ProductListModel(
                  numoriginal: '',
                  cod: splitedCod[1],
                  codUnit: splitedUnit[1],
                  ref: splitedRef[1],
                  qtd: splitedQtd[1],
                  fab: splitedFab[1],
                  valueTable: splitedValueTable[1],
                  controllerDiscount: controllerDiscount,
                  controllerValueUnit: controllerValueUnit,
                  total: splitedTotal[1],
                  item: splitedItem[1],
                  input: splitedInput[1],
                  indexAssembly: i
              )
          );
        }

      }
      _dataSearchClient();
      _dataSearchProd();
      if (_listAssembly.length != 0) {
        _controllerClientName.addListener(_searchClient);
        _listAssembly[0].cod.addListener(_searchCodUnico);
        _listAssembly[0].ref.addListener(_searchRef);
        _listAssembly[0].term1.addListener(_searchProd);
        _listAssembly[0].term2.addListener(_searchProd);
        _listAssembly[0].cape.addListener(_searchProd);
        _listAssembly[0].adap1.addListener(_searchProd);
        _listAssembly[0].adap2.addListener(_searchProd);
        _listAssembly[0].hose.addListener(_searchProd);
      }
    });
  }

  init() {
    _addList();
    createId();
    _dataSearchClient();
    _dataSearchProd();
    _dataSearchCodUnico();
    if (_listAssembly.length != 0) {
      _controllerClientName.addListener(_searchClient);
      _listAssembly[0].cod.addListener(_searchCodUnico);
      _listAssembly[0].ref.addListener(_searchRef);
      _listAssembly[0].term1.addListener(_searchProd);
      _listAssembly[0].term2.addListener(_searchProd);
      _listAssembly[0].cape.addListener(_searchProd);
      _listAssembly[0].adap1.addListener(_searchProd);
      _listAssembly[0].adap2.addListener(_searchProd);
      _listAssembly[0].hose.addListener(_searchProd);
    }
    _getOrder();
  }

  Future sequenceUpdate(String cod, bool update, int i) async {
    if (update) {
      var splited = cod.split(" ");
      cod = '${splited[0]} - ${splited[2]}';
      DocumentSnapshot snapshot = await db.collection('codUnico').doc(cod).get();
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      int rep = data?['rep'] ?? 0;
      String letter1 = listLetter[rep <= 25 ? 0 : rep - 25];
      String letter2 = listLetter[(rep / 25).round()];

      db.collection('codUnico').doc(cod).update({'rep': rep+1+i}).then((value) => setState(() {
        _listAssembly[i].cod = TextEditingController(text: cod);
      }));
      FirebaseFirestore.instance.collection('assembly').doc(id).set({
        'codUnit'         : FieldValue.arrayUnion(['$i#${_listAssembly[i].cod.text}']),
        'codAssembly'     : FieldValue.arrayUnion(['$i#${_listAssembly[i].cod.text}']),
      }, SetOptions(merge: true));
    } else {
      DocumentSnapshot snapshot = await db.collection('order').doc('codSequence').get();
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      int numberSequence = data?['numberSequence'];
        if (numberSequence != null) {
          _listAssembly[i].letter1 = listLetter[numberSequence <= 100 ? 0 : numberSequence - 100];
          _listAssembly[i].letter2 = listLetter[(numberSequence / 100).round()];
          _listAssembly[i].cod = TextEditingController(text: '${_listAssembly[i].letter1}${_listAssembly[i].letter2}${numberSequence < 10 ? 0 : ''}${(numberSequence+i)} - AA');
          db.collection('order').doc('codSequence').set({
            'letterFirst': _listAssembly[i].letter1.toUpperCase(),
            'letterSecond': _listAssembly[i].letter2.toUpperCase(),
            'numberSequence': numberSequence+1+i
          }).then((value) => setState(() {
                _listAssembly[i].codRep = true;

                for (int index = 0; index < _listProduct.length; index++) {
                  db.collection('codUnico').doc(_listAssembly[i].cod.text.toUpperCase()).set({
                        'items': FieldValue.arrayUnion(['$index#${_listProduct[index].item}']),
                        'cod': FieldValue.arrayUnion(['$index#${_listProduct[index].cod}']),
                        'fabricante': FieldValue.arrayUnion([_listProduct[index].fab              == ''? '$index#vazio' : '$index#${_listProduct[index].fab}']),
                        'valorTabela': FieldValue.arrayUnion([_listProduct[index].valueTable            == ''? '$index#0.00'  : '$index#${_listProduct[index].valueTable}']),
                        'desconto': FieldValue.arrayUnion([_listProduct[index].controllerDiscount.text             == ''? '$index#0.00'  : '$index#${_listProduct[index].controllerDiscount.text}']),
                        'valorUnitario': FieldValue.arrayUnion([_listProduct[index].controllerValueUnit.text   == ''? '$index#0.00'  : '$index#${_listProduct[index].controllerValueUnit.text}']),
                        'total': FieldValue.arrayUnion([_listProduct[index].total                        == ''? '$index#0.00'  : '$index#${_listProduct[index].total}']),
                        'input': FieldValue.arrayUnion([_listProduct[index].input                        == ''? '$index#000'   : '$index#${_listProduct[index].input}']),
                      }, SetOptions(merge: true));
                  FirebaseFirestore.instance.collection('assembly').doc(id).set({
                    'codUnit'         : FieldValue.arrayUnion(['$i#${_listAssembly[i].cod.text}']),
                    'codAssembly'     : FieldValue.arrayUnion(['$i#${_listAssembly[i].cod.text}']),
                  }, SetOptions(merge: true));
                }
                setState(() {});
                db.collection('codUnico').doc(_listAssembly[i].cod.text.toUpperCase()).set({
                  'codUnico': _listAssembly[i].cod.text,
                  'ref': _listAssembly[i].ref.text,
                  'rep': 1
                }, SetOptions(merge: true));
              }));
        }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.id == '') {
      init();
    } else {
      dataEdit();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Flex(
          direction: Axis.horizontal,
          children: [
            widget.id != '' ? Menu(index: 1) : Container(),
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
                child: loadingData ? Center(
                        child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 20),
                          Text('Coletando informações ...')
                        ],
                      )): SingleChildScrollView(
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
                                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
                                    onChanged: (value) {},
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
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        if (value != '') {
                                          loadingCliente = true;
                                          _dataClient(value.toString());
                                        } else {
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
                                  child: loadingCliente
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 50, height: 30),
                                              SizedBox(
                                                  height: 25,
                                                  width: 25,
                                                  child:CircularProgressIndicator()),
                                              SizedBox(width: 20),
                                              Text('Procurando cliente. Aguarde ...',
                                                style: TextStyle(
                                                    color:PaletteColors.primaryColor),
                                              )
                                            ],
                                          ),
                                        )
                                      : InputRegister(
                                          height: 50.0,
                                          controller: _controllerClientName,
                                          hint:'Digite o código do cliente cadastrado',
                                          fonts: 14.0,
                                          keyboardType: TextInputType.datetime,
                                          width: width * 0.2,
                                          sizeIcon: 0.01,
                                          icons: Icons.height,
                                          colorBorder: PaletteColors.inputGrey,
                                          background: PaletteColors.inputGrey,
                                          onChanged: (value) {
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
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ), //Inputs
                            valueClient != ''? Container(
                                    height: heigth * 0.3,
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: _controllerItems.stream,
                                        builder: (context, snapshot) {
                                          return ListView.builder(
                                              itemCount: _resultsClient.length,
                                              itemBuilder: (contect, index) {
                                                DocumentSnapshot item = _resultsClient[index];
                                                return ListTile(
                                                  title: Text('CÓDIGO: ${item['codcli']}, CLIENTE: ${item['cliente']}, ENDEREÇO: ${item['enderent']}, CIDADE: ${item['municient']}'),
                                                  onTap: () => setState(() {
                                                    _controllerClientName = TextEditingController(text: item['cliente']);
                                                    _controllerClientCod = TextEditingController(text: item['codcli']);
                                                    valueClient = '';
                                                  }),
                                                );
                                              });
                                        })) : Container(),
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
                              height: _listAssembly.length * 60,
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: ListView.builder(
                                  itemCount: _listAssembly.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      color: _listAssembly[index].selected?PaletteColors.primaryColor:PaletteColors.white,
                                      child: ListTile(
                                        onTap: (){
                                          setState(() {
                                            _listAssembly[index].selected? _listAssembly[index].selected=false : _listAssembly[index].selected=true;
                                            _listAssembly[index].selected?indexDuplicate = index:indexDuplicate=null;
                                          });
                                        },
                                        title: Row(
                                          children: [
                                            Container(
                                              width: width * 0.06,
                                              child: InputRegister(
                                                controller: _listAssembly[index].cod,
                                                hint: '0000',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.text,
                                                width: width * 0.06,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value) {
                                                    if (value.toString() != '') {
                                                      setState(() {
                                                        indexGlobal = index;
                                                        valuecodProd = value.toString();
                                                      });
                                                    } else {
                                                      valuecodProd = '';
                                                    }
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.05,
                                              margin: EdgeInsets.only(left: 3),
                                              child: InputRegister(
                                                controller: _listAssembly[index].ref,
                                                hint: 'AAA',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.text,
                                                width: width * 0.05,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value) {
                                                    if (value.toString() != '') {
                                                      setState(() {
                                                        indexGlobal = index;
                                                        valuecodProd = value.toString();
                                                        _listAssembly[index].ref =TextEditingController(text: value.toString());
                                                      });
                                                    } else {
                                                      valuecodProd = '';
                                                    }
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.035,
                                              margin: EdgeInsets.only(left: 8),
                                              child: InputRegister(
                                                controller: _listAssembly[index].qtd,
                                                hint: '00',
                                                fonts: 12.0,
                                                width: width * 0.035,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                onChanged: (value)=>setState(()=>indexGlobal = index),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.05,
                                              child: InputRegister(
                                                controller: _listAssembly[index].maker,
                                                hint: 'AAA',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.text,
                                                width: width * 0.05,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value)=>setState(()=>indexGlobal = index),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.11,
                                              child: InputRegister(
                                                controller:_listAssembly[index].application,
                                                hint: 'AAA',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.text,
                                                width: width * 0.11,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value)=>setState(()=>indexGlobal = index),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.05,
                                              child: InputRegister(
                                                controller: _listAssembly[index].hose,
                                                hint: '0000',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.text,
                                                width: width * 0.05,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value != '') {
                                                      setState(()=>indexGlobal = index);
                                                      valueProd = value.toString();
                                                      resultSearchListProd('hose');
                                                    } else {
                                                      _listAssembly[index].hose = TextEditingController(text: '');
                                                      valueProd = '';
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.04,
                                              child: InputRegister(
                                                controller: _listAssembly[index].comp,
                                                hint: '0,00',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.number,
                                                width: width * 0.04,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value)=>setState(()=>indexGlobal = index),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.035,
                                              child: InputRegister(
                                                controller: _listAssembly[index].size,
                                                hint: 'PP',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.text,
                                                width: width * 0.035,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value)=>setState(()=>indexGlobal = index),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.045,
                                              child: InputRegister(
                                                controller: _listAssembly[index].term1,
                                                hint: '000',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.text,
                                                width: width * 0.045,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value) {
                                                    setState(() {
                                                      if (value != '') {
                                                        setState(()=>indexGlobal = index);
                                                        valueProd = value.toString();
                                                        resultSearchListProd('term1');
                                                      } else {
                                                        _listAssembly[index].term1 =TextEditingController(text: '');
                                                        valueProd = '';
                                                      }
                                                  });
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.045,
                                              child: InputRegister(
                                                controller: _listAssembly[index].term2,
                                                hint: '000',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.text,
                                                width: width * 0.045,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value) {
                                                    setState(() {
                                                      if (value != '') {
                                                        setState(()=>indexGlobal = index);
                                                        valueProd = value.toString();
                                                        resultSearchListProd('term2');
                                                      } else {
                                                        _listAssembly[index].term2 = TextEditingController(text: '');
                                                        valueProd = '';
                                                      }
                                                  });
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.045,
                                              child: InputRegister(
                                                controller: _listAssembly[index].cape,
                                                hint: '000',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.text,
                                                width: width * 0.45,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value) {
                                                    setState(() {
                                                      if (value != '') {
                                                        setState(()=>indexGlobal = index);
                                                        valueProd = value.toString();
                                                        resultSearchListProd('case');
                                                      } else {
                                                        _listAssembly[index].cape =TextEditingController(text: '');
                                                        valueProd = '';
                                                      }
                                                  });
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.032,
                                              child: InputRegister(
                                                controller: _listAssembly[index].pos,
                                                hint: '',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.text,
                                                width: width * 0.032,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value)=>setState(()=>indexGlobal = index),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.045,
                                              child: InputRegister(
                                                controller: _listAssembly[index].adap1,
                                                hint: '',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.text,
                                                width: width * 0.045,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value) {
                                                    setState(() {
                                                      if (value != '') {
                                                        setState(()=>indexGlobal = index);
                                                        valueProd = value.toString();
                                                        resultSearchListProd('adap1');
                                                      } else {
                                                        _listAssembly[index].adap1 =TextEditingController(text: '');
                                                        valueProd = '';
                                                      }
                                                    });
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.045,
                                              child: InputRegister(
                                                controller: _listAssembly[index].adap2,
                                                hint: '',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.text,
                                                width: width * 0.045,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value) {
                                                    setState(() {
                                                      if (value != '') {
                                                        setState(()=>indexGlobal = index);
                                                        valueProd = value.toString();
                                                        resultSearchListProd('adap2');
                                                      } else {
                                                        _listAssembly[index].adap2 =TextEditingController(text: '');
                                                        valueProd = '';
                                                      }
                                                  });
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.03,
                                              child: InputRegister(
                                                enable: false,
                                                controller: _listAssembly[index].ring,
                                                hint: '',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.text,
                                                width: width * 0.03,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value) {},
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.03,
                                              child: InputRegister(
                                                controller: _listAssembly[index].spring,
                                                hint: '',
                                                fonts: 12.0,
                                                keyboardType: TextInputType.text,
                                                width: width * 0.03,
                                                sizeIcon: 0.01,
                                                icons: Icons.height,
                                                colorBorder: PaletteColors.inputGrey,
                                                background: PaletteColors.inputGrey,
                                                onChanged: (value)=>setState(()=>indexGlobal = index),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            valueProd != ''? Container(
                                    height: heigth * 0.3,
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: _controllerItems.stream,
                                        builder: (context, snapshot) {
                                          return ListView.builder(
                                              itemCount: _resultsProd.length,
                                              itemBuilder: (contect, index) {
                                                DocumentSnapshot item = _resultsProd[index];

                                                return ListTile(
                                                  title: Text('NUMERO ORIGINAL: ${item['numoriginal']},CÓDIGO: ${item['codprod']}, MARCA: ${item['marca']}, ESTOQUE 1: ${item['estf1']}, ESTOQUE 2: ${item['estf2']}, PREÇO: ${item['preco']}'),
                                                  onTap: () => setState((){
                                                    var name = '';
                                                    var input = '';
                                                    if (_listAssembly[indexGlobal].term1.text.isNotEmpty && valueProd ==_listAssembly[indexGlobal].term1.text) {
                                                      _listAssembly[indexGlobal].term1 = TextEditingController(text: item['numoriginal']);
                                                      _listAssembly[indexGlobal].term1Price = item['preco'];
                                                      _listAssembly[indexGlobal].term1Brand = item['marca'];
                                                      _listAssembly[indexGlobal].descTerm1 ='${item['tipoterminal']}';
                                                      if(item['codoring']!='null'&& item['codoring']!=null){
                                                        setState(() {
                                                          _listAssembly[indexGlobal].ring = TextEditingController(text: 'X');
                                                        });
                                                        Future.delayed(Duration.zero,()async{
                                                          DocumentSnapshot snapshot = await db.collection('produtos').doc(item['codoring']).get();
                                                          Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
                                                          _listProduct.add(
                                                              ProductListModel(
                                                                  numoriginal:data!['numoriginal'],
                                                                  cod: data['codprod'],
                                                                  codUnit: _listAssembly[indexGlobal].cod.text,
                                                                  ref: data['numoriginal'].toString(),
                                                                  qtd: _listAssembly[indexGlobal].qtd.text,
                                                                  fab: data['marca'],
                                                                  valueTable:'${(double.parse(data['preco']) *(name == 'case1'?int.parse(_listAssembly[indexGlobal].qtd.text)*2:int.parse(_listAssembly[indexGlobal].qtd.text))).toStringAsFixed(2).replaceAll('.', ',')}',
                                                                  controllerDiscount:TextEditingController(text: 'R\$ 0,00'),
                                                                  controllerValueUnit: TextEditingController(text: 'R\$ ${data['preco'].toString().replaceAll('.', ',')}'),
                                                                  total: 'R\$ ${(double.parse(data['preco']) * (name == 'case1'?int.parse(_listAssembly[indexGlobal].qtd.text)*2:int.parse(_listAssembly[indexGlobal].qtd.text))).toStringAsFixed(2).replaceAll('.', ',')}',
                                                                  item: 'anel',
                                                                  input: data['informacoestecnicas'],
                                                                  indexAssembly: indexGlobal
                                                              )
                                                          );
                                                        });
                                                      }
                                                      name = 'term1';
                                                      input = _listAssembly[indexGlobal].term1.text;
                                                    }
                                                    if (_listAssembly[indexGlobal].term2.text.isNotEmpty && valueProd == _listAssembly[indexGlobal].term2.text) {
                                                      _listAssembly[indexGlobal].term2 =TextEditingController(text: item['numoriginal']);
                                                      _listAssembly[indexGlobal].term2Price = item['preco'];
                                                      _listAssembly[indexGlobal].term2Brand = item['marca'];
                                                      _listAssembly[indexGlobal].descTerm2 ='${item['tipoterminal']}';
                                                      name = 'term2';
                                                      input = _listAssembly[indexGlobal].term2.text;
                                                      if(item['codoring']!='null'&& item['codoring']!=null){
                                                        setState(() {
                                                          _listAssembly[indexGlobal].ring = TextEditingController(text: 'X');
                                                        });
                                                        Future.delayed(Duration.zero,()async{
                                                          DocumentSnapshot snapshot = await db.collection('produtos').doc(item['codoring']).get();
                                                          Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
                                                          _listProduct.add(
                                                              ProductListModel(
                                                                  numoriginal:data!['numoriginal'],
                                                                  cod: data['codprod'],
                                                                  codUnit: _listAssembly[indexGlobal].cod.text,
                                                                  ref: data['numoriginal'].toString(),
                                                                  qtd: _listAssembly[indexGlobal].qtd.text,
                                                                  fab: data['marca'],
                                                                  valueTable:'${(double.parse(data['preco']) *(name == 'case1'?int.parse(_listAssembly[indexGlobal].qtd.text)*2:int.parse(_listAssembly[indexGlobal].qtd.text))).toStringAsFixed(2).replaceAll('.', ',')}',
                                                                  controllerDiscount:TextEditingController(text: 'R\$ 0,00'),
                                                                  controllerValueUnit: TextEditingController(text: 'R\$ ${data['preco'].toString().replaceAll('.', ',')}'),
                                                                  total: 'R\$ ${(double.parse(data['preco']) * (name == 'case1'?int.parse(_listAssembly[indexGlobal].qtd.text)*2:int.parse(_listAssembly[indexGlobal].qtd.text))).toStringAsFixed(2).replaceAll('.', ',')}',
                                                                  item: 'anel',
                                                                  input: data['informacoestecnicas'],
                                                                  indexAssembly: indexGlobal
                                                              )
                                                          );
                                                        });
                                                      }
                                                    }
                                                    if (_listAssembly[indexGlobal].cape.text.isNotEmpty && valueProd == _listAssembly[indexGlobal].cape.text) {
                                                      _listAssembly[indexGlobal].cape =TextEditingController(text: item['numoriginal']);
                                                      _listAssembly[indexGlobal].capePrice = item['preco'];
                                                      _listAssembly[indexGlobal].capeBrand = item['marca'];
                                                      name = 'case1';
                                                      input = _listAssembly[indexGlobal].cape.text;
                                                    }
                                                    if (_listAssembly[indexGlobal].adap1.text.isNotEmpty && valueProd ==_listAssembly[indexGlobal].adap1.text) {
                                                      _listAssembly[indexGlobal].adap1 = TextEditingController(text: item['numoriginal']);
                                                      _listAssembly[indexGlobal].adap1Price = item['preco'];
                                                      _listAssembly[indexGlobal].adap1Brand = item['marca'];
                                                      name = 'adap1';
                                                      input = _listAssembly[indexGlobal].adap1.text;
                                                    }
                                                    if (_listAssembly[indexGlobal].adap2.text.isNotEmpty &&
                                                        valueProd ==_listAssembly[indexGlobal].adap2.text) {
                                                      _listAssembly[indexGlobal].adap2 = TextEditingController(text: item['numoriginal']);
                                                      _listAssembly[indexGlobal].adap2Price = item['preco'];
                                                      _listAssembly[indexGlobal].adap2Brand = item['marca'];
                                                      name = 'adap2';
                                                      input = _listAssembly[indexGlobal].adap2.text;
                                                    }
                                                    if (_listAssembly[indexGlobal].hose.text.isNotEmpty && valueProd == _listAssembly[indexGlobal].hose.text) {
                                                      _listAssembly[indexGlobal].hose = TextEditingController(text: item['numoriginal']);
                                                      _listAssembly[indexGlobal].hosePrice = item['preco'];
                                                      _listAssembly[indexGlobal].hoseBrand = item['marca'];
                                                      name = 'hose';
                                                      input = _listAssembly[indexGlobal].hose.text;
                                                      _listAssembly[indexGlobal].pressureHose ='${item['diametro']}';
                                                      _listAssembly[indexGlobal].pressureHose ='${item['pressao']}';
                                                    }
                                                    valueProd = '';
                                                    _listProduct.add(
                                                      ProductListModel(
                                                        numoriginal:item['numoriginal'],
                                                        cod: item['codprod'],
                                                        codUnit: _listAssembly[indexGlobal].cod.text,
                                                        ref: item['numoriginal'].toString(),
                                                        qtd: name == 'case1'? (double.parse(_listAssembly[indexGlobal].qtd.text) *2.0).toString(): _listAssembly[indexGlobal].qtd.text,
                                                        fab: item['marca'],
                                                        valueTable:'${(double.parse(item['preco']) *(name == 'case1'?int.parse(_listAssembly[indexGlobal].qtd.text)*2:int.parse(_listAssembly[indexGlobal].qtd.text))).toStringAsFixed(2).replaceAll('.', ',')}',
                                                        controllerDiscount:TextEditingController(text: 'R\$ 0,00'),
                                                        controllerValueUnit: TextEditingController(text: 'R\$ ${item['preco'].toString().replaceAll('.', ',')}'),
                                                        total: 'R\$ ${(double.parse(item['preco']) * (name == 'case1'?int.parse(_listAssembly[indexGlobal].qtd.text)*2:int.parse(_listAssembly[indexGlobal].qtd.text))).toStringAsFixed(2).replaceAll('.', ',')}',
                                                        item: name,
                                                        input: input,
                                                       indexAssembly: indexGlobal
                                                      )
                                                    );
                                                  }),
                                                );
                                              });
                                        })) : Container(),
                            valuecodProd!='' && _resultsCodUnico.length!=0? Container(
                                height: heigth*0.3,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: _controllerItems.stream,
                                    builder: (context,snapshot){
                                      return ListView.builder(
                                          itemCount: _resultsCodUnico.length,
                                          itemBuilder: (contect,index){
                                            DocumentSnapshot item = _resultsCodUnico[index];

                                            return   ErrorIntModel(item,'rep')==0?Container():ListTile(
                                                title: Text('Cód. Unico: ${item['codUnico']}, Referência: ${item['ref']}, Mangueira: ${item['input'][0].toString().toUpperCase()}, Term1: ${item['input'][1].toString().toUpperCase()}, Term2: ${item['input'][2].toString().toUpperCase()}, Capa: ${item['input'][3].toString().toUpperCase()}, POS: ${item['input'][4].toString().toUpperCase()}'),
                                                onTap: (){
                                                  setState(() {
                                                    valuecodProd='';
                                                    _listAssembly[indexGlobal].codRep = true;
                                                    _listAssembly[indexGlobal].cod = TextEditingController(text:item['codUnico']);
                                                    _listAssembly[indexGlobal].ref = TextEditingController(text:item['ref']);
                                                    _listAssembly[indexGlobal].hose = TextEditingController(text:item['input'][0].toString().toUpperCase());
                                                    _listAssembly[indexGlobal].term1 = TextEditingController(text:item['input'][1].toString().toUpperCase());
                                                    _listAssembly[indexGlobal].term2 = TextEditingController(text:item['input'][2].toString().toUpperCase());
                                                    _listAssembly[indexGlobal].cape = TextEditingController(text:item['input'][3].toString().toUpperCase());
                                                  });
                                                  sequenceUpdate(_listAssembly[indexGlobal].cod.text,true,indexGlobal);
                                                }
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
                                        }),
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

                                            var _controllerCodProduct = TextEditingController(text: _listAssembly[indexDuplicate!].cod.text);
                                            var _controllerRef = TextEditingController(text: _listAssembly[indexDuplicate!].ref.text);
                                            var _controllerQtd = TextEditingController(text: _listAssembly[indexDuplicate!].qtd.text);
                                            var _controllerMaker = TextEditingController(text: _listAssembly[indexDuplicate!].maker.text);
                                            var _controllerAplication = TextEditingController(text: _listAssembly[indexDuplicate!].application.text);
                                            var _controllerSize = TextEditingController(text: _listAssembly[indexDuplicate!].size.text);
                                            var _controllerComp = TextEditingController(text: _listAssembly[indexDuplicate!].comp.text);
                                            var _controllerHose = TextEditingController(text: _listAssembly[indexDuplicate!].hose.text);
                                            var _controllerTerm1 = TextEditingController(text: _listAssembly[indexDuplicate!].term1.text);
                                            var _controllerTerm2 = TextEditingController(text: _listAssembly[indexDuplicate!].term2.text);
                                            var _controllerCase = TextEditingController(text: _listAssembly[indexDuplicate!].cape.text);
                                            var _controllerPos = TextEditingController(text: _listAssembly[indexDuplicate!].pos.text);
                                            var _controllerAdap1 = TextEditingController(text: _listAssembly[indexDuplicate!].adap1.text);
                                            var _controllerAdap2 = TextEditingController(text: _listAssembly[indexDuplicate!].adap2.text);
                                            var _controllerRing = TextEditingController(text: _listAssembly[indexDuplicate!].ring.text);
                                            var _controllerSpring = TextEditingController(text: _listAssembly[indexDuplicate!].spring.text);
                                            var hosePrice = _listAssembly[indexDuplicate!].hosePrice;
                                            var hoseBrand = _listAssembly[indexDuplicate!].hoseBrand;
                                            var term1Price = _listAssembly[indexDuplicate!].term1Price;
                                            var term1Brand = _listAssembly[indexDuplicate!].term1Brand;
                                            var term2Price = _listAssembly[indexDuplicate!].term2Price;
                                            var term2Brand = _listAssembly[indexDuplicate!].term2Brand;
                                            var capePrice = _listAssembly[indexDuplicate!].capePrice;
                                            var capeBrand = _listAssembly[indexDuplicate!].capeBrand;
                                            var adap1Price = _listAssembly[indexDuplicate!].adap1Price;
                                            var adap1Brand = _listAssembly[indexDuplicate!].adap1Brand;
                                            var adap2Price = _listAssembly[indexDuplicate!].adap2Price;
                                            var adap2Brand = _listAssembly[indexDuplicate!].adap2Brand;
                                            var diameterHose = _listAssembly[indexDuplicate!].diameterHose;
                                            var pressureHose = _listAssembly[indexDuplicate!].pressureHose;
                                            var descTerm1 = _listAssembly[indexDuplicate!].descTerm1;
                                            var descTerm2 = _listAssembly[indexDuplicate!].descTerm2;
                                            var hoseQtd = _listAssembly[indexDuplicate!].hoseQtd;
                                            var term1Qtd = _listAssembly[indexDuplicate!].term1Qtd;
                                            var term2Qtd = _listAssembly[indexDuplicate!].term2Qtd;
                                            var capeQtd = _listAssembly[indexDuplicate!].capeQtd;
                                            var adap1Qtd = _listAssembly[indexDuplicate!].adap1Qtd;
                                            var adap2Qtd = _listAssembly[indexDuplicate!].adap2Qtd;
                                            var ringQtd = _listAssembly[indexDuplicate!].ringQtd;
                                            var springQtd = _listAssembly[indexDuplicate!].springQtd;

                                            _listAssembly.add(
                                                AssemblyListModel(
                                                  cod: _controllerCodProduct,
                                                  ref: _controllerRef,
                                                  qtd: _controllerQtd,
                                                  maker: _controllerMaker,
                                                  application: _controllerAplication,
                                                  size:_controllerSize,
                                                  comp:_controllerComp,
                                                  hose:_controllerHose,
                                                  hosePrice: hosePrice,
                                                  hoseBrand: hoseBrand,
                                                  hoseQtd: hoseQtd,
                                                  term1: _controllerTerm1,
                                                  term1Price: term1Price,
                                                  term1Brand: term1Brand,
                                                  term1Qtd: term1Qtd,
                                                  term2: _controllerTerm2,
                                                  term2Price: term2Price,
                                                  term2Brand: term2Brand,
                                                  term2Qtd: term2Qtd,
                                                  cape: _controllerCase,
                                                  capePrice: capePrice,
                                                  capeBrand: capeBrand,
                                                  capeQtd: capeQtd,
                                                  pos: _controllerPos,
                                                  adap1: _controllerAdap1,
                                                  adap1Price: adap1Price,
                                                  adap1Brand: adap1Brand,
                                                  adap1Qtd: adap1Qtd,
                                                  adap2: _controllerAdap2,
                                                  adap2Price: adap2Price,
                                                  adap2Brand: adap2Brand,
                                                  adap2Qtd: adap2Qtd,
                                                  ring: _controllerRing,
                                                  ringQtd: ringQtd,
                                                  spring: _controllerSpring,
                                                  springQtd: springQtd,
                                                  valueTable: 'R\$ 00,00',
                                                  discount: TextEditingController(text: '0'),
                                                  valueUnit: TextEditingController(text: 'R\$ 00,00'),
                                                  total:'R\$ 00,00',
                                                  diameterHose: diameterHose,
                                                  pressureHose: pressureHose,
                                                  descTerm1: descTerm1,
                                                  descTerm2: descTerm2,
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
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 100),
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
                                      setState(() =>loadingData = true);
                                      FirebaseFirestore.instance.collection('assembly').doc(id).delete();
                                      for (var i = 0; _listAssembly.length > i; i++) {
                                        insertList(i);
                                        sequenceUpdate(_listAssembly[i].cod.text != ''? _listAssembly[i].cod.text: '',_listAssembly[i].cod.text != ''? true : false,i).then((value) =>
                                          setState(() {
                                            FirebaseFirestore.instance.collection('assembly').doc(id).set({
                                              'refAssembly'         : FieldValue.arrayUnion(['$i#${_listAssembly[i].ref.text}']),
                                              'qtdAssembly'         : FieldValue.arrayUnion(['$i#${_listAssembly[i].qtd.text}']),
                                              'makerAssembly'       : FieldValue.arrayUnion(['$i#${_listAssembly[i].maker.text}']),
                                              'apliAssembly'        : FieldValue.arrayUnion(['$i#${_listAssembly[i].application.text}']),
                                              'hoseAssembly'        : FieldValue.arrayUnion(['$i#${_listAssembly[i].hose.text}']),
                                              'hosePriceAssembly'   : FieldValue.arrayUnion(['$i#${_listAssembly[i].hosePrice}']),
                                              'hoseBrandAssembly'   : FieldValue.arrayUnion(['$i#${_listAssembly[i].hoseBrand}']),
                                              'term1Assembly'       : FieldValue.arrayUnion(['$i#${_listAssembly[i].term1.text}']),
                                              'term1PriceAssembly'  : FieldValue.arrayUnion(['$i#${_listAssembly[i].term1Price}']),
                                              'term1BrandAssembly'  : FieldValue.arrayUnion(['$i#${_listAssembly[i].term1Brand}']),
                                              'descTerm1Assembly'   : FieldValue.arrayUnion(['$i#${_listAssembly[i].descTerm1}']),
                                              'term2Assembly'       : FieldValue.arrayUnion(['$i#${_listAssembly[i].term2.text}']),
                                              'term2PriceAssembly'  : FieldValue.arrayUnion(['$i#${_listAssembly[i].term2Price}']),
                                              'term2BrandAssembly'  : FieldValue.arrayUnion(['$i#${_listAssembly[i].term2Brand}']),
                                              'descTer21Assembly'   : FieldValue.arrayUnion(['$i#${_listAssembly[i].descTerm2}']),
                                              'capeAssembly'        : FieldValue.arrayUnion(['$i#${_listAssembly[i].cape.text}']),
                                              'capePriceAssembly'   : FieldValue.arrayUnion(['$i#${_listAssembly[i].capePrice}']),
                                              'capeBrandAssembly'   : FieldValue.arrayUnion(['$i#${_listAssembly[i].capeBrand}']),
                                              'adap1Assembly'       : FieldValue.arrayUnion(['$i#${_listAssembly[i].adap1.text}']),
                                              'adap1PriceAssembly'  : FieldValue.arrayUnion(['$i#${_listAssembly[i].adap1Price}']),
                                              'adap1BrandAssembly'  : FieldValue.arrayUnion(['$i#${_listAssembly[i].adap1Brand}']),
                                              'adap2Assembly'       : FieldValue.arrayUnion(['$i#${_listAssembly[i].adap2.text}']),
                                              'adap2PriceAssembly'  : FieldValue.arrayUnion(['$i#${_listAssembly[i].adap2Price}']),
                                              'adap2BrandAssembly'  : FieldValue.arrayUnion(['$i#${_listAssembly[i].adap2Brand}']),
                                              'ringAssembly'        : FieldValue.arrayUnion(['$i#${_listAssembly[i].ring.text}']),
                                              'springAssembly'      : FieldValue.arrayUnion(['$i#${_listAssembly[i].spring.text}']),
                                              'diameterHoseAssembly': FieldValue.arrayUnion(['$i#${_listAssembly[i].diameterHose}']),
                                              'pressureHoseAssembly': FieldValue.arrayUnion(['$i#${_listAssembly[i].pressureHose}']),
                                              'pos'                 : FieldValue.arrayUnion(['$i#${_listAssembly[i].pos.text}']),
                                              'lengthAssembly'      : FieldValue.arrayUnion(['$i#${_listAssembly[i].comp.text}']),
                                              'sizeAssembly'        : FieldValue.arrayUnion(['$i#${_listAssembly[i].size.text}']),
                                            },SetOptions(merge: true));

                                            for (var ip = 0;_listProduct.length > ip;ip++) {
                                              if(_listProduct[ip].indexAssembly == i){
                                                FirebaseFirestore.instance.collection('assembly').doc(id).set({
                                                  'codProd$i'         : FieldValue.arrayUnion(['$ip#${_listProduct[ip].cod}']),
                                                  'refProd$i'         : FieldValue.arrayUnion(['$ip#${_listProduct[ip].ref}']),
                                                  'qtdProd$i'         : FieldValue.arrayUnion(['$ip#${_listProduct[ip].qtd}']),
                                                  'fabProd$i'         : FieldValue.arrayUnion(['$ip#${_listProduct[ip].fab}']),
                                                  'valueTableProd$i'  : FieldValue.arrayUnion(['$ip#${_listProduct[ip].valueTable}']),
                                                  'discountProd$i'    : FieldValue.arrayUnion(['$ip#${_listProduct[ip].controllerDiscount.text}']),
                                                  'valueUnitProd$i'   : FieldValue.arrayUnion(['$ip#${_listProduct[ip].controllerValueUnit.text}']),
                                                  'totalProd$i'       : FieldValue.arrayUnion(['$ip#${_listProduct[ip].total}']),
                                                  'itemProd$i'        : FieldValue.arrayUnion(['$ip#${_listProduct[ip].item}']),
                                                  'inputProd$i'       : FieldValue.arrayUnion(['$ip#${_listProduct[ip].input}']),
                                                },SetOptions(merge: true));
                                              }
                                              _listProduct[ip].codUnit =_listAssembly[i].cod.text;
                                            }

                                              FirebaseFirestore.instance.collection('assembly').doc(id).set({
                                                'id': id,
                                                'data':_controllerDate != null ? _controllerDate.text: '',
                                                'codcli':_controllerClientCod !=null? _controllerClientCod.text: '',
                                                'client':_controllerClientName !=null? _controllerClientName.text: '',
                                                'subsidiary':_controllerAffiliation != null? _controllerAffiliation.text: '',
                                                'dateOrder': DateTime.now(),
                                                'status':status==''?TextConst.aguardando:status,
                                                'order': order.toString(),
                                                'priority':selectedPriority,
                                                'whinthor':whinthor
                                              },SetOptions(merge: true)).then((value) {
                                                db.collection('order').doc('order').update({
                                                  'order': int.parse(order.toString())
                                                }).then((value) =>
                                                    Navigator.push(context,new MaterialPageRoute(builder:(context) =>
                                                    new PriceScreen(
                                                      saveListModel:_listAssembly,
                                                      saveListProduct:_listProduct,
                                                      idAssembly:id,
                                                      client:_controllerClientName.text,
                                                      codClient:_controllerClientCod.text,
                                                      order:order.toString(),
                                                      data:_controllerDate.text,
                                                      subsidiary:_controllerAffiliation.text,
                                                    )
                                                    ))
                                                );
                                              });
                                              setState(()=>  loadingData = false);
                                          }));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
        ),
      ]),
    );
  }
}