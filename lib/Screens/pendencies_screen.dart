import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montagem_web/Models/error_string_model.dart';

import '../Models/error_int_model.dart';
import '../Utils/exports.dart';
import '../Utils/text_const.dart';

class PendenciesScreen extends StatefulWidget {
  const PendenciesScreen({Key? key}) : super(key: key);

  @override
  State<PendenciesScreen> createState() => _PendenciesScreenState();
}

class _PendenciesScreenState extends State<PendenciesScreen> {

  var _controllerItems = StreamController<QuerySnapshot>.broadcast();
  FirebaseFirestore db = FirebaseFirestore.instance;
  List _allResult = [];
  List <ListIconModel> listModel =[];
  bool loading = true;
  
  _dataGet()async{
    var data = await db.collection("assembly").orderBy('priority').get();
    setState(() {
      _allResult = data.docs;
      loading = false;
    });
    return "complete";
  }

  @override
  void initState() {
    super.initState();
    _dataGet();
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
      child: Container(
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
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextCustom(
                      text: 'Pedidos Pendentes de Produção',
                      size: 20.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ), //Titulo
              SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(width: 30),
                  TextCustom(
                    text: 'Montagens pendentes de produção',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ), //Textos
              SizedBox(height: 35),
              Row(
                children: [
                  SizedBox(width: 30),
                  Container(
                    width: width * 0.12,
                    child: TextCustom(
                      text: 'Ordem de Produção',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.10,
                    child: TextCustom(
                      text: 'Orçamento Whintor',
                      maxLines: 4,
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.start,
                    ),
                  ),
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
                    width: width * 0.22,
                    child: TextCustom(
                      text: 'Cliente',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.09,
                    child: TextCustom(
                      text: 'Prioridade',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width * 0.1,
                    child: TextCustom(
                      text: 'Status',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: heigth*0.8,
                child: loading
                ?Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 100,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()
                        ),
                        SizedBox(width: 50,),
                        Container(
                          child: Text('Carregando ...',style: TextStyle(color: PaletteColors.primaryColor,fontSize: 30),),
                        )
                      ],
                    ),
                  ],
                )
                :StreamBuilder(
                  stream: _controllerItems.stream,
                  builder: (context, snapshot) {

                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if(_allResult.length == 0){
                          return Center(
                              child: Text('Nenhum pedido pendente',
                                style: TextStyle(fontSize: 30,color: PaletteColors.primaryColor),)
                          );
                        }else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                itemCount: _allResult.length,
                                itemBuilder: (BuildContext context, index) {
                                  DocumentSnapshot item = _allResult[index];

                                  listModel.add(
                                      ListIconModel(
                                          date: ErrorStringModel(item, 'data'),
                                          assembly: ErrorIntModel(item,'makerOrder')!=''?ErrorIntModel(item,'makerOrder'):0000,
                                          client: '${ErrorStringModel(item, 'codcli')} - ${ErrorStringModel(item, 'cliente')}',
                                          number: ErrorStringModel(item,'order')!=''?ErrorStringModel(item,'order'):'0000',
                                          winthor: ErrorStringModel(item,'whinthor')
                                      )
                                  );

                                  return TextConst.cancelado == ErrorStringModel(item,'status') ||  TextConst.finalizado ==ErrorStringModel(item,'status')
                                      ?Container()
                                      :ListTileButtom(
                                        makerOrder: ErrorIntModel(item,'makerOrder')!=0?ErrorIntModel(item,'makerOrder'):0000,
                                        whintor: ErrorStringModel(item,'whinthor'),
                                        date: ErrorStringModel(item, 'data'),
                                        client: '${ErrorStringModel(item, 'codcli')} - ${ErrorStringModel(item, 'cliente')}',
                                        priority: ErrorStringModel(item,'priority').toUpperCase(),
                                        status: ErrorStringModel(item,'status').toUpperCase(),
                                        showButtom: listModel[index].iconShow,
                                        args: ErrorStringModel(item,'id'),
                                        onTap: () {
                                          setState(() {
                                            listModel[index].iconShow==false?listModel[index].iconShow=true:listModel[index].iconShow=false;
                                          });
                                        },
                                        hovercolor: Colors.white,
                                      );
                                }
                            ),
                          );
                        }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
