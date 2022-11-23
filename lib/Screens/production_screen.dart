import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montagem_web/Widgets/list_hoses_assemble.dart';
import '../Models/controllers_assembly_list_model.dart';
import '../Models/product_list_model.dart';
import '../Utils/exports.dart';
import '../Utils/text_const.dart';
import '../Widgets/list_material.dart';

class ProductionScreen extends StatefulWidget {

  final String id;

  ProductionScreen(this.id);

  @override
  State<ProductionScreen> createState() => _ProductionScreenState();
}

class _ProductionScreenState extends State<ProductionScreen> {
  final listRoutes = [
    HomeScreen(),
    AssemblyScreen(id: '',),
    HistoryScreen(),
    PendenciesScreen(),
    ProductionScreen(''),
  ];
  var currentIndex = 0;

  String? selectedPriority = '';

  FirebaseFirestore db = FirebaseFirestore.instance;
  var _controllerDate = TextEditingController();
  var _controllerWhintor = TextEditingController();
  var _controllerOrder = TextEditingController();
  var _controllerObservation = TextEditingController();
  var _controllerObservationProd = TextEditingController();
  List <ProductListModel> _listProduct = [];
  List <ControllersAssemblyListModel> listProdutos = [];
  String cod = '';
  int indexGlobal = 0;

  _data() async {
    DocumentSnapshot snapshot = await db.collection("assembly").doc(widget.id).get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    setState(() {
      _controllerDate = TextEditingController(text: data?["data"]);
      _controllerWhintor = TextEditingController(text: data?["whinthor"]);
      _controllerOrder = TextEditingController(text: data?["makerOrder"].toString());
      _controllerObservation = TextEditingController(text: data?["obs"]);
      _controllerObservationProd = TextEditingController(text: data?["obsProd"]??'');
      selectedPriority = data?['priority'];

      List codAssembly    = data?['codAssembly']??[];
      List qtdAssembly    = data?['qtdAssembly']??[];
      List hoseAssembly   = data?['hoseAssembly']??[];
      List sizeAssembly   = data?['sizeAssembly']??[];
      List lengthAssembly = data?['lengthAssembly']??[];
      List term1Assembly  = data?['term1Assembly']??[];
      List term2Assembly  = data?['term2Assembly']??[];
      List capeAssembly   = data?['capeAssembly']??[];
      List adap1Assembly  = data?['adap1Assembly']??[];
      List adap2Assembly  = data?['adap2Assembly']??[];
      List ringAssembly   = data?['ringAssembly']??[];
      List springAssembly = data?['springAssembly']??[];
      List makerAssembly  = data?['makerAssembly']??[];
      List apliAssembly   = data?['apliAssembly']??[];
      List pos            = data?['pos']??[];

      for(var i=0;codAssembly.length>i;i++){

        var splitedCod    = codAssembly[i].toString().split('#');
        var splitedQtd    = qtdAssembly[i].toString().split('#');
        var splitedHose   = hoseAssembly[i].toString().split('#');
        var splitedLength = lengthAssembly[i].toString().split('#');
        var splitedSize   = sizeAssembly[i].toString().split('#');
        var splitedTerm1  = term1Assembly[i].toString().split('#');
        var splitedTerm2  = term2Assembly[i].toString().split('#');
        var splitedCape   = capeAssembly[i].toString().split('#');
        var splitedAdap1  = adap1Assembly[i].toString().split('#');
        var splitedAdap2  = adap2Assembly[i].toString().split('#');
        var splitedRing   = ringAssembly[i].toString().split('#');
        var splitedSpring = springAssembly[i].toString().split('#');
        var splitedMaker  = makerAssembly[i].toString().split('#');
        var splitedApli   = apliAssembly[i].toString().split('#');
        var splitedPos    = pos[i].toString().split('#');
        listProdutos.add(
            ControllersAssemblyListModel(
              cod: splitedCod[1], qtd: splitedQtd[1], number: '${i+1}', hose: splitedHose[1], size: splitedSize[1], length: splitedLength[1],
              term1: splitedTerm1[1], term2: splitedTerm2[1],cape: splitedCape[1], pos: splitedPos[1], adap1: splitedAdap1[1], adap2: splitedAdap2[1],
              ring: splitedRing[1], spring: splitedSpring[1], maker: splitedMaker[1],application: splitedApli[1],
            )
        );
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
      setState(() {
        cod = listProdutos[0].cod;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _data();
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Flex(
          direction: Axis.horizontal,
          children: [
          Menu(index: 3),
          Flexible(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60.0),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: TextCustom(
                              text: 'Produção',
                              size: 20.0,
                              color: PaletteColors.primaryColor,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ), //Titulo
                      SizedBox(height:6),
                      Row(
                        children: [
                          SizedBox(width: 30),
                          Container(
                            width: width * 0.11,
                            child: TextCustom(
                              text: 'Data',
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
                            width: width * 0.1,
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
                              text: 'Prioridade',
                              size: 14.0,
                              color: PaletteColors.primaryColor,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),//Textos
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Container(
                            width: width * 0.11,
                            child: InputRegister(
                              enable: false,
                              controller: _controllerDate,
                              hint: '00/00/0000',
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
                              enable: false,
                              controller: _controllerWhintor,
                              hint: '00000000000000',
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
                            width: width * 0.1,
                            child: InputRegister(
                              enable: false,
                              controller: _controllerOrder,
                              hint: '00000000',
                              fonts: 14.0,
                              keyboardType: TextInputType.number,
                              width: width * 0.08,
                              sizeIcon: 0.01,
                              icons: Icons.height,
                              colorBorder: PaletteColors.inputGrey,
                              background: PaletteColors.inputGrey,
                              onChanged: (value){},
                            ),
                          ),
                          Container(
                            width: width * 0.10,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: PaletteColors.inputGrey),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextCustom(
                                text: selectedPriority,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                          Spacer(),
                          ButtonCustom(
                            widthCustom: 0.1,
                            heightCustom: 0.065,
                            text: "Finalizar Produção",
                            size: 14.0,
                            colorText: PaletteColors.white,
                            colorButton: PaletteColors.primaryColor,
                            colorBorder: PaletteColors.primaryColor,
                            font: 'Nunito',
                            onPressed: (){
                                FirebaseFirestore.instance.collection('assembly').doc(widget.id).update({
                                  'status':TextConst.finalizado,
                                  'obsProd':_controllerObservationProd.text
                                }).then((value) => Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => NavigationScreen(index: 3))));
                            }
                          ),
                          SizedBox(width: width *0.06)
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          SizedBox(width: 30),
                          Container(
                            width: width * 0.46,
                            child: TextCustom(
                              text: 'Observação Vendedor',
                              size: 14.0,
                              color: PaletteColors.primaryColor,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Container(
                            width: width * 0.47,
                            child: InputRegister(
                              enable: false,
                              controller: _controllerObservation,
                              hint: 'sem observação',
                              fonts: 14.0,
                              keyboardType: TextInputType.number,
                              width: width * 0.46,
                              sizeIcon: 0.01,
                              icons: Icons.height,
                              colorBorder: PaletteColors.inputGrey,
                              background: PaletteColors.inputGrey,
                              onChanged: (value){},
                            ),
                          ),
                          Spacer(),
                          ButtonCustom(
                            widthCustom: 0.1,
                            heightCustom: 0.065,
                            text: "Imprimir",
                            size: 14.0,
                            colorText: PaletteColors.white,
                            colorButton: PaletteColors.primaryColor,
                            colorBorder: PaletteColors.primaryColor,
                            onPressed: () =>
                                Navigator.popAndPushNamed(context, '/home'),
                            font: 'Nunito',
                          ),
                          SizedBox(width: width *0.06)
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          SizedBox(width: 30),
                          Container(
                            width: width * 0.47,
                            child: TextCustom(
                              text: 'Observação sobre a Produção',
                              size: 14.0,
                              color: PaletteColors.primaryColor,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Container(
                            width: width * 0.47,
                            child: InputRegister(
                              controller: _controllerObservationProd,
                              hint: 'Anote sua observação',
                              fonts: 14.0,
                              keyboardType: TextInputType.number,
                              width: width * 0.46,
                              sizeIcon: 0.01,
                              icons: Icons.height,
                              colorBorder: PaletteColors.inputGrey,
                              background: PaletteColors.inputGrey,
                              onChanged: (value){},
                            ),
                          ),
                          Spacer(),
                          ButtonCustom(
                            widthCustom: 0.1,
                            heightCustom: 0.065,
                            text: "Cancelar Produção",
                            size: 14.0,
                            colorText: PaletteColors.white,
                            colorButton: PaletteColors.cancel,
                            colorBorder: PaletteColors.cancel,
                            font: 'Nunito',
                            onPressed: ()=>FirebaseFirestore.instance.collection('assembly').doc(widget.id).update({
                              'status':TextConst.cancelado,
                              'obsProd':_controllerObservationProd.text
                            }).then((value) => Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => NavigationScreen(index: 3)))),
                          ),
                          SizedBox(width: width *0.06)
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          SizedBox(width: 30),
                          TextCustom(
                            text: 'Material Solicitado',
                            size: 16.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          SizedBox(width: 30),
                          Container(
                            width: width * 0.09,
                            child: TextCustom(
                              text: 'Código',
                              size: 14.0,
                              color: PaletteColors.primaryColor,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                            width: width * 0.11,
                            child: TextCustom(
                              text: 'Rêferencia',
                              size: 14.0,
                              color: PaletteColors.primaryColor,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                            width: width * 0.07,
                            child: TextCustom(
                              text: 'Quantidade',
                              size: 14.0,
                              color: PaletteColors.primaryColor,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                            width: width * 0.07,
                            child: TextCustom(
                              text: 'Fabricante',
                              size: 14.0,
                              color: PaletteColors.primaryColor,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: heigth*0.4,
                        child: ListView.builder(
                          itemCount: _listProduct.length,
                          itemBuilder: (context,index){
                            return  indexGlobal != _listProduct[index].indexAssembly?Container():
                              ListMaterial(
                                screenscreen: 'production',
                                enable: false,
                                hovercolor: Colors.white,
                                cod: _listProduct[index].codUnit.toUpperCase(),
                                ref: _listProduct[index].ref.toUpperCase(),
                                qtd: _listProduct[index].qtd,
                                manufacturer: _listProduct[index].fab.toUpperCase(),
                                valuetable: '',
                                discount: _listProduct[index].controllerDiscount,
                                valueUnit: _listProduct[index].controllerValueUnit,
                                onChangeDiscount: (){},
                                onChangeValueUnit: (){},
                                total:'' ,
                              );
                          }
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(width: 30),
                          TextCustom(
                            text: 'Mangueiras a montar',
                            size: 16.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          SizedBox(width: 30),
                          Container(
                            width: width * 0.05,
                            child: TextCustom(
                              text: 'N°',
                              size: 14.0,
                              color: PaletteColors.primaryColor,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
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
                        height: heigth*0.2,
                        child: ListView.builder(
                          itemCount: listProdutos.length,
                          itemBuilder: (context,index){
                            return ListHosesAssemble(
                              hovercolor: PaletteColors.white,
                              cod: listProdutos[index].cod.toUpperCase(),
                              qtd: listProdutos[index].qtd.toUpperCase(),
                              number: listProdutos[index].number,
                              type: listProdutos[index].hose.toUpperCase(),
                              lenght: listProdutos[index].length.toUpperCase(),
                              // t: listProdutos[index].size.toUpperCase(),
                              term1: listProdutos[index].term1.toUpperCase(),
                              term2: listProdutos[index].term2.toUpperCase(),
                              cape: listProdutos[index].cape.toUpperCase(),
                              pos: listProdutos[index].pos.toUpperCase(),
                              adap1: listProdutos[index].adap1.toUpperCase(),
                              adap2: listProdutos[index].adap2.toUpperCase(),
                              an: listProdutos[index].ring.toUpperCase(),
                              mo: listProdutos[index].spring.toUpperCase(),
                              onTap: (){
                                setState(() {
                                  cod = listProdutos[index].cod;
                                  indexGlobal = index;
                                });
                              },
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}