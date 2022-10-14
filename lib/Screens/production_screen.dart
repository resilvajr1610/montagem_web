import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montagem_web/Widgets/list_hoses_assemble.dart';
import '../Models/product_model.dart';
import '../Models/save_list_product.dart';
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
  var _controllerNumberAssembly = TextEditingController();
  var _controllerWhintor = TextEditingController();
  var _controllerOrder = TextEditingController();
  var _controllerObservation = TextEditingController();
  var _controllerObservationProd = TextEditingController();
  List <SaveListProduct> listProdPrecos = [];
  List <ProductModel> listProdutos = [];
  String cod = '';

  _data() async {
    DocumentSnapshot snapshot = await db.collection("assembly").doc(widget.id).get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    setState(() {
      _controllerDate = TextEditingController(text: data?["data"]);
      _controllerWhintor = TextEditingController(text: data?["whinthor"]);
      _controllerOrder = TextEditingController(text: data?["order"]);
      _controllerObservation = TextEditingController(text: data?["obs"]);
      _controllerObservationProd = TextEditingController(text: data?["obsProd"]??'');
      selectedPriority = data?['priority'];
      List prodPrecos = data?['prodPrecos'];
      List produtos = data?['produtos'];
      for(var i=0;prodPrecos.length>i;i++){
        var splited = prodPrecos[i].toString().split('#');
        listProdPrecos.add(
            SaveListProduct(
                numoriginal: '', cod: splited[1], codUnico: splited[3], ref: splited[5], qtd: splited[7], fabricante: splited[9], valorTabela: splited[11],
                desconto: splited[13], valorUnitario: splited[15], total: splited[17]
            )
        );
      }
      for(var i=0;produtos.length>i;i++){
        var splited = produtos[i].toString().split('#');
        listProdutos.add(
            ProductModel(
                cod: splited[1], qtd: splited[5], number: '${i+1}', typeHose: splited[11], size: splited[13], type: splited[15],
                term1: splited[21], term2: splited[27],cape: splited[33], pos: splited[39], adap1: splited[41], adap2: splited[47], anel: splited[53], mola: splited[55])
        );
      }
      cod = listProdutos[0].cod;
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
                              if(_controllerWhintor.text.length==8){
                                FirebaseFirestore.instance.collection('assembly').doc(widget.id).update({
                                  'status':TextConst.finalizado,
                                  'obsProd':_controllerObservationProd.text
                                }).then((value) => Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => NavigationScreen(index: 3))));
                              }
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
                          itemCount: listProdPrecos.length,
                          itemBuilder: (context,index){
                            return cod == listProdPrecos[index].codUnico
                              ?ListMaterial(
                                hovercolor: Colors.white,
                                cod: listProdPrecos[index].codUnico.toUpperCase(),
                                ref: listProdPrecos[index].ref.toUpperCase(),
                                qtd: listProdPrecos[index].qtd,
                                manufacturer: listProdPrecos[index].fabricante.toUpperCase(),
                                valuetable: '',
                                discount: '',
                                value: '',
                                total:'' ,
                              ):Container();
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
                        height: heigth*0.2,
                        child: ListView.builder(
                          itemCount: listProdutos.length,
                          itemBuilder: (context,index){
                            return ListHosesAssemble(
                              hovercolor: PaletteColors.white,
                              cod: listProdutos[index].cod.toUpperCase(),
                              qtd: listProdutos[index].qtd.toUpperCase(),
                              number: listProdutos[index].number,
                              type: listProdutos[index].typeHose.toUpperCase(),
                              lenght: listProdutos[index].size.toUpperCase(),
                              t: listProdutos[index].type.toUpperCase(),
                              term1: listProdutos[index].term1.toUpperCase(),
                              term2: listProdutos[index].term2.toUpperCase(),
                              cape: listProdutos[index].cape.toUpperCase(),
                              pos: listProdutos[index].pos.toUpperCase(),
                              adap1: listProdutos[index].adap1.toUpperCase(),
                              adap2: listProdutos[index].adap2.toUpperCase(),
                              an: listProdutos[index].anel.toUpperCase(),
                              mo: listProdutos[index].mola.toUpperCase(),
                              onTap: (){
                                setState(() {
                                  cod = listProdutos[index].cod;
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