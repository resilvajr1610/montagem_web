import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montagem_web/Models/save_list_model.dart';
import 'package:montagem_web/Widgets/list_client.dart';
import 'package:montagem_web/Widgets/list_material.dart';
import '../Models/save_list_product.dart';
import '../Utils/exports.dart';
import '../Utils/text_const.dart';

class PriceScreen extends StatefulWidget {
  final List<SaveListModel> saveListModel;
  final List<SaveListProduct> saveListProduct;
  final String idAssembly;
  final String client;
  final String codClient;
  final String order;

  PriceScreen({required this.saveListModel,required this.saveListProduct,required this.idAssembly,required this.client,required this.codClient,required this.order});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  List<String> priority = ['1 - Cliente Balcão', '2 - Alta', '3 - Média', '4 - Baixa'];
  String? selectedPriority = '1 - Cliente Balcão';

  var _controllerNumberAssembly = TextEditingController();
  var _controllerWhintor = TextEditingController();
  var _controllerDiscount = TextEditingController();
  var _controllerObservation = TextEditingController();
  var codProduct='';
  double desconto=0.0;
  List<SaveListProduct> listGetProduct=[];
  String valorTabela = 'R\$ 0,00';
  String descAcrescentado = 'R\$ 0,00';
  String valorFinal = 'R\$ 0,00';
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    setState(() {
      codProduct=widget.saveListModel[0].cod.text;
      _controllerNumberAssembly = TextEditingController(text: widget.order);
      refreshValues();
    });
  }

  refreshValues(){
    double aplicado = 0.0;
    aplicado = desconto/100;
    double valorItem = 0.0;
    double totalItens =0.0;
    double valor = 0.0;
    double descontoTotal = 0.0;
    double descTabela = 0.0;
    double total = 0.0;
    double valorAtual = 0.0;
    setState(() {
      listGetProduct=[];
    });

    if(listGetProduct.length==0){
      for(var i=0;widget.saveListProduct.length>i;i++){
        listGetProduct.add(widget.saveListProduct[i]);
        valor = double.parse(listGetProduct[i].valorUnitario.toString().replaceAll(',', '.').replaceAll('R\$ ', ''));
        descontoTotal = valor*aplicado;
        valorItem = double.parse(listGetProduct[i].total.replaceAll('R\$ ', '').replaceAll(',', '.'));
        totalItens = totalItens+valorItem;
        listGetProduct[i].desconto = 'R\$ ${descontoTotal.toStringAsFixed(2).replaceAll('.', ',')}';
        valorAtual = valor - (valor*aplicado);
        listGetProduct[i].valorUnitario = 'R\$ ${valorAtual.toStringAsFixed(2).replaceAll('.', ',')}';
        listGetProduct[i].total = 'R\$ ${valorAtual.toStringAsFixed(2).replaceAll('.', ',')}';
      }

      descTabela = totalItens*aplicado;
      total = totalItens-descTabela;

      valorTabela = 'R\$ ${totalItens.toStringAsFixed(2).replaceAll('.', ',')}';
      descAcrescentado = 'R\$ ${descTabela.toStringAsFixed(2).replaceAll('.', ',')}';
      valorFinal = 'R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}';
      setState(() {});
      for(var i=0; widget.saveListModel.length>i;i++){
        if(widget.saveListModel[i].cod == codProduct){
          widget.saveListModel[i].valorTabela = valorTabela;
          widget.saveListModel[i].desconto = descAcrescentado;
          widget.saveListModel[i].total = valorFinal;
        }
      }
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
          Menu(index: 1),
          Flexible(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 100.0),
              height: heigth*1.4,
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
                            text: 'Produtos e precificação',
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
                          width: width* 0.12,
                          child: TextCustom(
                            text: 'Nº de montagem',
                            size: 14.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          width: width* 0.13,
                          child: TextCustom(
                            text: 'Orçamento Whintor',
                            size: 14.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          width: width* 0.10,
                          child: TextCustom(
                            text: 'Prioridade',
                            size: 14.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          width: width* 0.13,
                          child: TextCustom(
                            text: '',
                            size: 14.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          width: width* 0.07,
                          child: TextCustom(
                            text: 'Desconto geral',
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
                          width: width * 0.12,
                          child: InputRegister(
                            enable: false,
                            controller: _controllerNumberAssembly,
                            hint: '0000000',
                            fonts: 14.0,
                            keyboardType: TextInputType.number,
                            width: width * 0.08,
                            sizeIcon: 0.01,
                            icons: Icons.height,
                            colorBorder: PaletteColors.inputGrey,
                            background: PaletteColors.inputGrey,
                            onChanged: (v){},
                          ),
                        ),
                        Container(
                          width: width * 0.13,
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
                            onChanged: (v){},
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
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                iconSize: 30.0,
                                items: priority
                                    .map((priority) => DropdownMenuItem<String>(
                                        value: priority,
                                        child: TextCustom(
                                          text: priority,
                                          color: PaletteColors.grey,
                                          fontFamily: 'Nunito',
                                        )))
                                    .toList(),
                                value: selectedPriority,
                                onChanged: (priority) =>
                                    setState(() => selectedPriority = priority),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: width* 0.13,
                          child: TextCustom(
                            text: '',
                            size: 14.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          width: width * 0.07,
                          child: InputRegister(
                            controller: _controllerDiscount,
                            hint: '00%',
                            fonts: 14.0,
                            keyboardType: TextInputType.text,
                            width: width * 0.04,
                            sizeIcon: 0.01,
                            icons: Icons.height,
                            colorBorder: PaletteColors.inputGrey,
                            background: PaletteColors.inputGrey,
                            onChanged: (v){
                              desconto = double.parse(v.toString().replaceAll(',', '.'));
                            },
                          ),
                        ),
                        ButtonCustom(
                          widthCustom: 0.07,
                          heightCustom: 0.065,
                          text: "Aplicar",
                          size: 14.0,
                          colorText: PaletteColors.white,
                          colorButton: PaletteColors.primaryColor,
                          colorBorder: PaletteColors.primaryColor,
                          onPressed: () {
                            refreshValues();
                          },
                          font: 'Nunito',
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        TextCustom(
                          text: 'Material solicitado',
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
                        Container(
                          width: width * 0.08,
                          child: TextCustom(
                            text: 'Valor Tabela',
                            size: 14.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          width: width * 0.07,
                          child: TextCustom(
                            text: 'Desconto',
                            size: 14.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          width: width * 0.07,
                          child: TextCustom(
                            text: 'Valor Unitario',
                            size: 14.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          width: width * 0.07,
                          child: TextCustom(
                            text: 'Total',
                            size: 14.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: heigth*0.3,
                      child: listGetProduct.length!=0?ListView.builder(
                        itemCount: listGetProduct.length,
                        itemBuilder: (context,index){
                          return  codProduct == listGetProduct[index].codUnico
                              ?ListMaterial(
                                hovercolor: Colors.white,
                                cod: listGetProduct[index].cod,
                                ref: listGetProduct[index].ref.toUpperCase(),
                                qtd: listGetProduct[index].qtd,
                                manufacturer: listGetProduct[index].fabricante.toUpperCase(),
                                valuetable: 'R\$ ${listGetProduct[index].valorTabela.replaceAll('.', ',')}',
                                discount: '${listGetProduct[index].desconto}',
                                value: '${listGetProduct[index].valorUnitario.replaceAll('.', ',')}',
                                total:'${listGetProduct[index].total.replaceAll('.', ',')}' ,
                              ):Container();
                        }
                      ):CircularProgressIndicator(),
                    ),
                    SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     SizedBox(width: 40),
                    //     Material(
                    //       color: Colors.transparent,
                    //       child: Ink(
                    //         decoration: ShapeDecoration(
                    //           color: PaletteColors.primaryColor,
                    //           shape: CircleBorder(),
                    //         ),
                    //         child: IconButton(
                    //           icon: Icon(
                    //             Icons.add,
                    //             color: PaletteColors.white,
                    //             size: 16.0,
                    //           ),
                    //           constraints: BoxConstraints(
                    //             minWidth: 20,
                    //             maxWidth: 20,
                    //             minHeight: 20,
                    //             maxHeight: 20,
                    //           ),
                    //           padding: EdgeInsets.zero,
                    //           onPressed: () {
                    //
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.5,
                              child: TextCustom(
                                text: '   Observação',
                                size: 14.0,
                                color: PaletteColors.primaryColor,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                           Container(
                              height: 75,
                             width: width * 0.5,
                              child: InputRegister(
                                controller: _controllerObservation,
                                hint: 'observação',
                                fonts: 14.0,
                                keyboardType: TextInputType.text,
                                width: width * 0.5,
                                sizeIcon: 0.01,
                                icons: Icons.height,
                                colorBorder: PaletteColors.inputGrey,
                                background: PaletteColors.inputGrey,
                                onChanged: (v){},
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 45),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: PaletteColors.inputGrey,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        TextCustom(
                                          text: 'Valor Tabela',
                                          size: 14.0,
                                          color: PaletteColors.primaryColor,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.normal,
                                          textAlign: TextAlign.start,
                                        ),
                                        TextCustom(
                                          text: 'Desc/ Acres',
                                          size: 14.0,
                                          color: PaletteColors.primaryColor,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.normal,
                                          textAlign: TextAlign.start,
                                        ),
                                        TextCustom(
                                          text: 'Outras Desp',
                                          size: 14.0,
                                          color: PaletteColors.primaryColor,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.normal,
                                          textAlign: TextAlign.start,
                                        ),
                                        TextCustom(
                                          text: 'Valor Final',
                                          size: 14.0,
                                          color: PaletteColors.primaryColor,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        TextCustom(
                                          text: valorTabela,
                                          size: 14.0,
                                          color: PaletteColors.grey,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.normal,
                                        ),
                                        TextCustom(
                                          text: descAcrescentado,
                                          size: 14.0,
                                          color: PaletteColors.grey,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.normal,
                                        ),
                                        TextCustom(
                                          text: 'R\$ 000,00',
                                          size: 14.0,
                                          color: PaletteColors.grey,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.normal,
                                        ),
                                        TextCustom(
                                          text: valorFinal,
                                          size: 14.0,
                                          color: PaletteColors.grey,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 240),
                        ButtonCustom(
                          widthCustom: 0.08,
                          heightCustom: 0.06,
                          text: "Retornar",
                          size: 14.0,
                          colorText: PaletteColors.white,
                          colorButton: PaletteColors.primaryColor,
                          colorBorder: PaletteColors.primaryColor,
                          onPressed: () =>
                              Navigator.pop(context),
                          font: 'Nunito',
                        ),
                        SizedBox(width: 20),
                        ButtonCustom(
                          widthCustom: 0.14,
                          heightCustom: 0.06,
                          text: "Gravar Orçamento",
                          size: 14.0,
                          colorText: PaletteColors.white,
                          colorButton: PaletteColors.primaryColor,
                          colorBorder: PaletteColors.primaryColor,
                          onPressed: () {
                            db.collection('assembly').doc(widget.idAssembly).update({
                              'obs' : _controllerObservation.text.isNotEmpty?_controllerObservation.text:'',
                              'order' : _controllerNumberAssembly.text,
                              'whinthor' : _controllerWhintor.text.isNotEmpty?_controllerWhintor.text:'',
                              'priority' : selectedPriority,
                              'discountPercent' : _controllerDiscount.text.isNotEmpty?_controllerDiscount.text:'0',
                              'discountTotal': descAcrescentado,
                              'totalFinal': valorFinal,
                              'status' : TextConst.aguardando
                            }).then((value) => db.collection('order').doc('order').update({
                              'order':int.parse(_controllerNumberAssembly.text)
                            }).then((value) => Navigator.pushReplacementNamed(context, '/home')));
                          },
                          font: 'Nunito',
                        ),
                        SizedBox(width: 20),
                        ButtonCustom(
                          widthCustom: 0.16,
                          heightCustom: 0.06,
                          text: "Enviar para produção",
                          size: 14.0,
                          colorText: PaletteColors.white,
                          colorButton: PaletteColors.primaryColor,
                          colorBorder: PaletteColors.primaryColor,
                          onPressed: () {},
                          font: 'Nunito',
                        ),
                        SizedBox(width: 20),
                        ButtonCustom(
                          widthCustom: 0.08,
                          heightCustom: 0.06,
                          text: "Imprimir",
                          size: 14.0,
                          colorText: PaletteColors.white,
                          colorButton: PaletteColors.primaryColor,
                          colorBorder: PaletteColors.primaryColor,
                          onPressed: (){},
                          font: 'Nunito',
                        ),
                        SizedBox(width: 20),
                        ButtonCustom(
                          widthCustom: 0.08,
                          heightCustom: 0.06,
                          text: "Descrição",
                          size: 14.0,
                          colorText: PaletteColors.white,
                          colorButton: PaletteColors.primaryColor,
                          colorBorder: PaletteColors.primaryColor,
                          onPressed: (){},
                          font: 'Nunito',
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        TextCustom(
                          text: 'Cliente:',
                          size: 14.0,
                          color: PaletteColors.primaryColor,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,

                        ),
                        SizedBox(width: 20),
                        TextCustom(
                          text: '${widget.codClient }- ${widget.client}',
                          size: 14.0,
                          color: PaletteColors.grey,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.normal,

                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Container(
                          width: width * 0.07,
                          child: TextCustom(
                            text: 'Qtd',
                            size: 14.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,

                          ),
                        ),
                        Container(
                          width: width * 0.27 ,
                          child: TextCustom(
                            text: 'Descrição',
                            size: 14.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,

                          ),
                        ),
                        Container(
                          width: width * 0.08 ,
                          child: TextCustom(
                            text: 'Valor Tabela',
                            size: 14.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,

                          ),
                        ),
                        Container(
                          width: width * 0.07,
                          child: TextCustom(
                            text: 'Desconto',
                            size: 14.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,

                          ),
                        ),
                        Container(
                          width: width * 0.09 ,
                          child: TextCustom(
                            text: 'Valor Unitário',
                            size: 14.0,
                            color: PaletteColors.primaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          width: width * 0.08 ,
                          child: TextCustom(
                            text: 'Total',
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
                      height: widget.saveListModel.length*70,
                      child: ListView.builder(
                          itemCount: widget.saveListModel.length,
                          itemBuilder: (context,index){
                            return ListClient(
                              hovercolor: Colors.white,
                              qtd: widget.saveListModel[index].qtd.text,
                              description: widget.saveListModel[index].application.text,
                              valuetable: '${widget.saveListModel[index].valorTabela}',
                              discount: '${widget.saveListModel[index].desconto}',
                              value: '${widget.saveListModel[index].valorUnitario}',
                              total:'${widget.saveListModel[index].total}' ,
                              onTap: (){
                                setState(() {
                                  codProduct = widget.saveListModel[index].cod.text;
                                  print('codProduct $codProduct');
                                });
                              },
                            );
                          }
                      ),
                    ),
                    SizedBox(height: 4),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(color: PaletteColors.primaryColor),
                                  color: PaletteColors.white,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4.0),
                                      child: Column(
                                        children: [
                                          TextCustom(
                                            text: 'Valor bruto',
                                            size: 14.0,
                                            color: PaletteColors.primaryColor,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.normal,
                                            textAlign: TextAlign.start,
                                          ),
                                          TextCustom(
                                            text: 'Desconto',
                                            size: 14.0,
                                            color: PaletteColors.primaryColor,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.normal,
                                            textAlign: TextAlign.start,
                                          ),
                                          TextCustom(
                                            text: 'Valor Final',
                                            size: 14.0,
                                            color: PaletteColors.primaryColor,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.bold,
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          TextCustom(
                                            text: 'R\$ 000,00',
                                            size: 14.0,
                                            color: PaletteColors.grey,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.normal,

                                          ),
                                          TextCustom(
                                            text: 'R\$ 000,00',
                                            size: 14.0,
                                            color: PaletteColors.grey,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.normal,

                                          ),
                                          TextCustom(
                                            text: 'R\$ 000,00',
                                            size: 14.0,
                                            color: PaletteColors.grey,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.bold,

                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 60),
                          ButtonCustom(
                            widthCustom: 0.08,
                            heightCustom: 0.06,
                            text: "Imprimir",
                            size: 14.0,
                            colorText: PaletteColors.white,
                            colorButton: PaletteColors.primaryColor,
                            colorBorder: PaletteColors.primaryColor,
                            onPressed: (){},
                            font: 'Nunito',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ]
      )
    );
  }
}
