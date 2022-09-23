import 'package:cloud_firestore/cloud_firestore.dart';

import '../Utils/exports.dart';

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
  
  _dataGet()async{
    var data = await db.collection("assembly").get();
    setState(() {
      _allResult = data.docs;
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
                      text: 'Data/ Hora',
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
                child: StreamBuilder(
                  stream: _controllerItems.stream,
                  builder: (context, snapshot) {

                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if(_allResult.length == 0){
                          return Center(
                              child: Text('Sem histórico',
                                style: TextStyle(fontSize: 20,),)
                          );
                        }else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                itemCount: _allResult.length,
                                itemBuilder: (BuildContext context, index) {
                                  DocumentSnapshot item = _allResult[index];

                                  listModel.add(
                                      ListIconModel(date: item['data'], assembly: 'falta adicionar', client: '${item['codcli']} - ${item['cliente']}', number: 'falta adicionar', winthor: item['whinthor'])
                                  );

                                  return ListTileButtom(
                                    order: 'falta adicionar',
                                    whintor: item['whinthor'],
                                    date: item['data'],
                                    client: '${item['codcli']} - ${item['cliente']}',
                                    priority: item['priority'],
                                    status: 'definir os status',
                                    showButtom: listModel[index].iconShow,
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
