import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montagem_web/Widgets/list_hoses_assemble.dart';

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
    AssemblyScreen(),
    HistoryScreen(),
    PendenciesScreen(),
    ProductionScreen(''),
  ];
  var currentIndex = 0;

  String? selectedPriority = '';

  var _controllerDate = TextEditingController();
  var _controllerNumberAssembly = TextEditingController();
  var _controllerWhintor = TextEditingController();
  var _controllerPriority = TextEditingController();
  var _controllerDiscount = TextEditingController();
  var _controllerObservation = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  _data() async {
    DocumentSnapshot snapshot = await db.collection("assembly").doc(widget.id).get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    setState(() {
      _controllerDate = TextEditingController(text: data?["data"]);
      _controllerWhintor = TextEditingController(text: data?["whinthor"]);
      selectedPriority = data?['priority'];
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.id);
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
                              controller: _controllerWhintor,
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
                            onPressed: ()=>FirebaseFirestore.instance.collection('assembly').doc(widget.id).update({
                              'status':TextConst.finalizado
                            }).then((value) => Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => NavigationScreen(index: 3)))),
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
                              text: 'Obs Vendedor',
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
                              controller: _controllerNumberAssembly,
                              hint: 'aaaaabbbbbbbccccccdddddd',
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
                              text: 'Obs sobra a Produção',
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
                              controller: _controllerNumberAssembly,
                              hint: 'aaaaabbbbbbbccccccdddddd',
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
                              'status':TextConst.cancelado
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
                      ListMaterial(
                        hovercolor: Colors.white,
                        cod: '00000',
                        ref: '00000000000',
                        qtd: '00',
                        manufacturer: 'NAC',
                        valuetable: '',
                        discount: '',
                        value: '',
                        total:'' ,
                      ),
                      ListMaterial(
                        hovercolor: Colors.white,
                        cod: '00000',
                        ref: '00000000000',
                        qtd: '00',
                        manufacturer: 'NAC',
                        valuetable: '',
                        discount: '',
                        value: '',
                        total:'' ,
                      ),
                      ListMaterial(
                        hovercolor: Colors.white,
                        cod: '00000',
                        ref: '00000000000',
                        qtd: '00',
                        manufacturer: 'NAC',
                        valuetable: '',
                        discount: '',
                        value: '',
                        total:'' ,
                      ),
                      ListMaterial(
                        hovercolor: Colors.white,
                        cod: '00000',
                        ref: '00000000000',
                        qtd: '00',
                        manufacturer: 'NAC',
                        valuetable: '',
                        discount: '',
                        value: '',
                        total:'' ,
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
                      ListHosesAssemble(
                        hovercolor: PaletteColors.white,
                        cod: 'SE41-A',
                        qtd: '3',
                        number: '1',
                        type: 'R2-12',
                        lenght: '0,54',
                        t: 'PP',
                        term1: 'FSP-12-12',
                        term2: 'FSP-12-12',
                        cape: 'CP2-12',
                        pos: '',
                        adap1: '',
                        adap2: '',
                        an: 'X',
                        mo: '',),
                      ListHosesAssemble(
                        hovercolor: PaletteColors.white,
                        cod: 'SE41-A',
                        qtd: '3',
                        number: '2',
                        type: 'R2-12',
                        lenght: '0,54',
                        t: 'PP',
                        term1: 'FSP-12-12',
                        term2: 'FSP-12-12',
                        cape: 'CP2-12',
                        pos: '',
                        adap1: '',
                        adap2: '',
                        an: 'X',
                        mo: '',)



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