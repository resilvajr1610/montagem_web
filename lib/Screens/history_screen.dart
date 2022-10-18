import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:montagem_web/Models/error_string_model.dart';
import 'package:montagem_web/Widgets/list_hoses_resume.dart';
import '../Models/error_int_model.dart';
import '../Models/product_model.dart';
import '../Utils/exports.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  var _controllerNumberAssembly = TextEditingController();
  var _controllerWhintor = TextEditingController();
  var _controllerNumberOp = TextEditingController();
  var _controllerClient = TextEditingController();
  var _controllerReference = TextEditingController();
  var _controllerInitialDate = TextEditingController();
  var _controllerFinalDate = TextEditingController();
  var _controllerItems = StreamController<QuerySnapshot>.broadcast();

  FirebaseFirestore db = FirebaseFirestore.instance;
  List <ProductModel> listProdutos = [];
  String cod = '';
  List _allResults=[];
  List show = [];

  _data() async {
    var data = await db.collection("assembly")
        .orderBy('order',descending: true)
        .get();
    setState(() {
      _allResults = data.docs;
    });
  }
  _dataSearch() async {
    _allResults.clear();
    var data;
    if(_controllerNumberAssembly.text.isNotEmpty && _controllerInitialDate.text.isEmpty){
       data = await db.collection("assembly")
          .where('order', isEqualTo: _controllerNumberAssembly.text.trim())
          .get();
    }
    if(_controllerFinalDate.text.isNotEmpty && _controllerInitialDate.text.isEmpty){
      data = await db.collection("assembly")
          .where('data', isLessThanOrEqualTo: _controllerFinalDate.text.trim())
          .get();
    }
    if(_controllerClient.text.isNotEmpty && _controllerInitialDate.text.isEmpty && _controllerNumberAssembly.text.isEmpty){
      data = await db.collection("assembly")
          .where('cliente', isEqualTo: _controllerClient.text.trim())
          .get();
    }
    if(_controllerInitialDate.text.isNotEmpty && _controllerNumberAssembly.text.isEmpty && _controllerFinalDate.text.isEmpty){
       data = await db.collection("assembly")
          .where('data', isGreaterThanOrEqualTo: _controllerInitialDate.text.trim())
          .get();
    }
    if(_controllerInitialDate.text.isNotEmpty && _controllerNumberAssembly.text.isNotEmpty){
      data = await db.collection("assembly")
          .where('data', isGreaterThanOrEqualTo: _controllerInitialDate.text.trim())
          .where('order', isEqualTo: _controllerNumberAssembly.text.trim())
          .get();
    }
    if(_controllerInitialDate.text.isNotEmpty && _controllerFinalDate.text.isNotEmpty){
      data = await db.collection("assembly")
          .where('data', isGreaterThanOrEqualTo: _controllerInitialDate.text.trim())
          .where('data', isLessThanOrEqualTo: _controllerFinalDate.text.trim())
          .get();
    }
    if(_controllerNumberOp.text.isNotEmpty && _controllerNumberAssembly.text.isEmpty && _controllerFinalDate.text.isEmpty){
      data = await db.collection("assembly")
          .where('makerOrder', isEqualTo: int.parse(_controllerNumberOp.text.trim()))
          .get();
    }
    setState(() {
      _allResults = data.docs;
      print(_allResults.length);
      if(_allResults.length==0){
        _data();
      }
    });
  }

  createList(List list){
    listProdutos.clear();
    for(var i=0;list.length>i;i++){
      var splited = list[i].toString().split('#');
      listProdutos.add(
          ProductModel(
              cod: splited[1], qtd: splited[5], number: '${i+1}', typeHose: splited[11], size: splited[13], type: splited[15],
              term1: splited[21], term2: splited[27],cape: splited[33], pos: splited[39], adap1: splited[41], adap2: splited[47], anel: splited[53], mola: splited[55],
              maquina: splited[7],aplicacao: splited[9],
          )
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _data();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 80.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextCustom(
                      text: 'Histórico de Montagens',
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
              Row(
                children: [
                  SizedBox(width: 30),
                  Container(
                    width: width * 0.11,
                    child: TextCustom(
                      text: 'Nº de montagem',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.12,
                    child: TextCustom(
                      text: 'Orçamento Whintor',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width* 0.07,
                    child: TextCustom(
                      text: 'Número OP',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width *0.26,

                    child: TextCustom(
                      text: 'Cliente',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ), //Textos
              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    width: width* 0.11,
                    child: InputRegister(
                      controller: _controllerNumberAssembly,
                      hint: '0000000',
                      fonts: 14.0,
                      keyboardType: TextInputType.number,
                      width: width * 0.09,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                  Container(
                    width: width* 0.12,
                    child: InputRegister(
                      controller: _controllerWhintor,
                      hint: '00000000',
                      fonts: 14.0,
                      keyboardType: TextInputType.number,
                      width: width * 0.1,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                  Container(
                    width: width * 0.07,
                    child: InputRegister(
                      controller: _controllerNumberOp,
                      hint: '000000',
                      fonts: 14.0,
                      keyboardType: TextInputType.number,
                      width: width * 0.06,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                  Container(
                    width: width * 0.22,
                    child: InputRegister(
                      controller: _controllerClient,
                      hint: 'cliente',
                      fonts: 14.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.25,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 30),
                  Container(
                    width: width *0.11,
                    child: TextCustom(
                      text: 'Referência',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width:  width * 0.12,
                    child: TextCustom(
                      text: 'Data inicial',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.12,
                    child: TextCustom(
                      text: 'Data final',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ), //Textos
              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    width: width* 0.11,
                    child: InputRegister(
                      controller: _controllerReference,
                      hint: '0000000',
                      fonts: 14.0,
                      keyboardType: TextInputType.number,
                      width: width * 0.09,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                      onChanged: (value){},
                    ),
                  ),
                  Container(
                    width: width * 0.12,
                    child: InputRegister(
                      controller: _controllerInitialDate,
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
                    width: width * 0.12,
                    child: InputRegister(
                      controller: _controllerFinalDate,
                      hint: '00/00/0000',
                      fonts: 14.0,
                      keyboardType: TextInputType.datetime,
                      width: width * 0.08,
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
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonCustom(
                      widthCustom: 0.13,
                      heightCustom: 0.06,
                      text: "Pesquisar",
                      size: 12.0,
                      colorText: PaletteColors.white,
                      colorButton: PaletteColors.primaryColor,
                      colorBorder: PaletteColors.primaryColor,
                      onPressed: () =>_dataSearch(),
                      font: 'Nunito',
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  SizedBox(width: 30),
                  TextCustom(
                    text: 'Resultado da pesquisa',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: width*0.07,
                    margin: const EdgeInsets.only(left: 30 ),
                    child: TextCustom(
                      text: 'Data',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: width*0.08,
                    margin: const EdgeInsets.symmetric(horizontal: 15 ),
                    child: TextCustom(
                      text: 'N° da montagem',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: width*0.15,
                    child: TextCustom(
                      text: 'Cliente',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15 ),
                    width: width*0.07,
                    child: TextCustom(
                      text: 'N° OP',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: width*0.1,
                    child: TextCustom(
                      text: 'Orçamento Winthor',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: width*0.1,
                    child: TextCustom(
                      text: 'Status',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Container(
                height: height*0.3,
                child: StreamBuilder(
                  stream: _controllerItems.stream,
                  builder: (context, snapshot) {

                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if(_allResults.length == 0){
                          return Center(
                              child: Text('Montagem finalizada não encontrada',
                                style: TextStyle(fontSize: 16,color: PaletteColors.primaryColor),)
                          );
                        }else {
                          return _allResults.length == 0?CircularProgressIndicator():ListView.builder(
                              itemCount: _allResults.length,
                              itemBuilder: (BuildContext context, index) {

                                DocumentSnapshot item = _allResults[index];
                                show.add(false);

                                return ListTileCustom(
                                  hovercolor: PaletteColors.white,
                                  date: item['data'],
                                  assembly: item['order'],
                                  client: item['cliente'],
                                  makerOrder: ErrorIntModel(item,'makerOrder').toString(),
                                  winthor: ErrorStringModel(item,'whinthor'),
                                  status: ErrorStringModel(item,'status'),
                                  showIcons: show[index],
                                  onTap: () {
                                    setState(() {
                                      if (show[index]) {
                                        show[index] = false;
                                      } else {
                                        show[index] = true;
                                      }
                                    });
                                  },
                                  onPressedShow: (){
                                    createList(item['produtos']);
                                  },
                                  onPressedEdit: ()=>Navigator.push(context, MaterialPageRoute(
                                    builder: (_) => AssemblyScreen(id: item['id'],)),
                                  ),
                                  onPressedDuplicated: (){},
                                );
                              }
                          );
                        }
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              Row(
                children: [
                  SizedBox(width: 30),
                  TextCustom(
                    text: 'Resumo das mangueiras',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 30),
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
                    width: width * 0.12,
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
                    width: width * 0.04,
                    child: TextCustom(
                      text: 'Compri',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.02,
                    child: TextCustom(
                      text: 'T',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.055,
                    child: TextCustom(
                      text: 'Term.1',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.055,
                    child: TextCustom(
                      text: 'Term.2',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.04,
                    child: TextCustom(
                      text: 'Capa',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.04,
                    child: TextCustom(
                      text: 'Pos.',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.04,
                    child: TextCustom(
                      text: 'Adap.1',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.04,
                    child: TextCustom(
                      text: 'Adap.2',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.02,
                    child: TextCustom(
                      text: 'AN',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.02,
                    child: TextCustom(
                      text: 'MO',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Container(
                height: height*0.3,
                child: ListView.builder(
                    itemCount: listProdutos.length,
                    itemBuilder: (context,index){
                      return  ListHosesResume(
                        hovercolor: Colors.white,
                        qtd: listProdutos[index].qtd,
                        machine: listProdutos[index].maquina,
                        application: listProdutos[index].aplicacao,
                        type: listProdutos[index].typeHose,
                        lenght: listProdutos[index].size,
                        t: listProdutos[index].type,
                        term1: listProdutos[index].term1,
                        term2: listProdutos[index].term2,
                        cape: listProdutos[index].cape,
                        pos: listProdutos[index].pos,
                        adap1: listProdutos[index].adap1,
                        adap2: listProdutos[index].adap2,
                        an: listProdutos[index].anel,
                        mo: listProdutos[index].mola,
                      );
                    }
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
