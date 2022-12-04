import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montagem_web/Models/pdf_model.dart';
import 'package:montagem_web/Models/assembly_list_model.dart';
import 'package:montagem_web/Widgets/list_client.dart';
import 'package:montagem_web/Widgets/list_material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../Models/pdf_tabela_model.dart';
import '../Models/product_list_model.dart';
import '../Utils/exports.dart';
import '../Utils/text_const.dart';
import '../services/pdf_model.dart';

class PriceScreen extends StatefulWidget {
  final List<AssemblyListModel> saveListModel;
  final List<ProductListModel> saveListProduct;
  final String idAssembly;
  final String client;
  final String codClient;
  final String order;
  final String data;
  final String subsidiary;
  final String obs;

  PriceScreen({
    required this.saveListModel,
    required this.saveListProduct,
    required this.idAssembly,
    required this.client,
    required this.codClient,
    required this.order,
    required this.data,
    required this.subsidiary,
    required this.obs
  });

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
  var _controllerDiscuntOther = TextEditingController(text: '');
  var codProduct='';
  double desconto=0.0;
  List<ProductListModel> listGetProduct=[];
  String valueTable = 'R\$ 0,00';
  String discount = 'R\$ 0,00';
  String descAcrescentado = 'R\$ 0,00';
  String valueFinal = 'R\$ 0,00';
  double brutoGeral = 0.00;
  double descGeral = 0.00;
  double liquidoGeral = 0.00;
  int indexGlobal = 0;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    setState(() {
      codProduct=widget.saveListModel[0].cod.text;
      dataFirebase();
      _controllerNumberAssembly = TextEditingController(text: widget.order);
      widget.obs!=''?_controllerObservation = TextEditingController(text: widget.obs):'';
      refreshValues();
    });
  }

  dataFirebase()async{
    DocumentSnapshot snapshot = await db.collection('assembly').doc(widget.idAssembly).get();
    if(snapshot!=null){
      setState(() {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
          selectedPriority = data?['priority']??'1 - Cliente Balcão';
          _controllerWhintor = TextEditingController(text: data?['whinthor']??'');
      });
    }
  }
  
  descontosGeral(){
    double desc = double.parse(_controllerDiscount.text.replaceAll(',','.'));
    double descTotal = (double.parse(widget.saveListModel[indexGlobal].valueTable.replaceAll('R\$ ', '').replaceAll(',', '.'))*desc)/100;
    double liquido = double.parse(widget.saveListModel[indexGlobal].valueTable.replaceAll('R\$ ', '').replaceAll(',', '.'))-descTotal;
    double uni = liquido/double.parse(widget.saveListProduct[indexGlobal].qtd);

    setState(() {
      valueFinal = 'R\$ ${liquido.toStringAsFixed(2).replaceAll('.', ',')}';
      valueTable = widget.saveListModel[indexGlobal].valueTable;
      descAcrescentado = 'R\$ ${descTotal.toStringAsFixed(2).replaceAll('.', ',')}';
      listGetProduct.clear();

      for (var i = 0; widget.saveListProduct.length > i; i++){

        double descTotalPecas = (double.parse(widget.saveListProduct[i].valueTable.replaceAll('R\$ ', '').replaceAll(',', '.'))*desc)/100;
        double liquidoPecas = double.parse(widget.saveListProduct[i].valueTable.replaceAll('R\$ ', '').replaceAll(',', '.'))-descTotal;
        double uniPecas = liquido/double.parse(widget.saveListProduct[i].qtd);
        discount = 'R\$ ${descTotalPecas.toStringAsFixed(2).replaceAll('.', ',')}';

          listGetProduct.add(
              ProductListModel(
                  numoriginal: widget.saveListProduct[i].numoriginal, cod: widget.saveListProduct[i].cod, codUnit: widget.saveListProduct[i].codUnit, ref: widget.saveListProduct[i].ref,
                  qtd: widget.saveListProduct[i].qtd, fab: widget.saveListProduct[i].fab,valueTable: widget.saveListProduct[i].valueTable,
                  controllerDiscount: TextEditingController(text: 'R\$ ${descTotalPecas.toStringAsFixed(2).replaceAll('.', ',')}'),controllerValueUnit: TextEditingController(text: 'R\$ ${uniPecas.toStringAsFixed(2).replaceAll('.', ',')}'),
                  total: 'R\$ ${liquidoPecas.toStringAsFixed(2).replaceAll('.', ',')}',item: widget.saveListProduct[i].item,input: widget.saveListProduct[i].input,indexAssembly: 0
              )
          );

      }
    });
  }

  refreshValues(){
    listGetProduct.clear();
    double total = 0.0;
    for (var i = 0;i < widget.saveListProduct.length; i++) {
      listGetProduct.add(widget.saveListProduct[i]);
    }
    for (var i = 0;i < listGetProduct.length; i++){
      if(codProduct == listGetProduct[i].codUnit && listGetProduct[i].qtd != '0'){
        total =  double.parse(listGetProduct[i].total.toString().replaceAll('R\$ ','').replaceAll(',', '.'))+total;
      }
    }
    setState(() {
      var uni = total/int.parse(widget.saveListModel[indexGlobal].qtd.text);
      valueTable = 'R\$ ${total.toStringAsFixed(2)}';
      valueFinal =  'R\$ ${total.toStringAsFixed(2)}';
      widget.saveListModel[indexGlobal].valueTable = total.toString();
      widget.saveListModel[indexGlobal].valueUnit = TextEditingController(text: 'R\$ ${uni.toStringAsFixed(2).replaceAll('.', ',')}');
      widget.saveListModel[indexGlobal].total = total.toString();
    });
}
  discountUnit(int index,String field){
    listGetProduct.clear();
    double total = 0.0;
    double totalDesc = 0.0;
    double totalValueTable = 0.0;
    for (var i = 0;i < widget.saveListProduct.length; i++) {
      listGetProduct.add(widget.saveListProduct[i]);
    }
    for (var i = 0;i < listGetProduct.length; i++){
      if(codProduct == listGetProduct[i].codUnit && listGetProduct[i].qtd != '0'){
        if(i!=index){
          total =  double.parse(listGetProduct[i].total.toString().replaceAll('R\$ ','').replaceAll(',', '.'))+total;
          print('total');
          print(total);
        }
      }
    }
    double valueUnit = double.parse(listGetProduct[index].controllerValueUnit.text.replaceAll('R\$ ','').replaceAll(',', '.'));
    int quantProd = int.parse(listGetProduct[index].qtd);
    setState(() {
      if(field == 'discount'){
        total = total - double.parse(listGetProduct[index].controllerDiscount.text.replaceAll('R\$ ','').replaceAll(',', '.'));
        listGetProduct[index].total = 'R\$ ' + ((quantProd*valueUnit)-double.parse(listGetProduct[index].controllerDiscount.text.replaceAll('R\$ ','').replaceAll(',', '.'))).toStringAsFixed(2).replaceAll('.', ',');
      }else{
        listGetProduct[index].total = 'R\$ '+ (valueUnit*quantProd).toStringAsFixed(2).replaceAll('.', ',');
        listGetProduct[index].total = 'R\$ ' + (double.parse(listGetProduct[index].total.replaceAll('R\$ ','').replaceAll(',', '.'))-double.parse(listGetProduct[index].controllerDiscount.text.replaceAll('R\$ ','').replaceAll(',', '.'))).toStringAsFixed(2).replaceAll('.', ',');
      }
      for (var i = 0;i < listGetProduct.length; i++){
            totalDesc =  double.parse(listGetProduct[i].controllerDiscount.text.replaceAll('R\$ ','').replaceAll(',', '.'))+totalDesc;
            descAcrescentado = 'R\$ '+ totalDesc.toStringAsFixed(2).replaceAll(".", ",");
      }
      for (var i = 0;i < listGetProduct.length; i++){
        if(codProduct == listGetProduct[i].codUnit && listGetProduct[i].qtd != '0'){
          totalValueTable =  double.parse(listGetProduct[i].total.toString().replaceAll('R\$ ','').replaceAll(',', '.'))+totalValueTable;
          valueTable = 'R\$ '+ (totalValueTable+totalDesc).toStringAsFixed(2).replaceAll(".", ",");
          valueFinal = 'R\$ '+ totalValueTable.toStringAsFixed(2).replaceAll(".", ",");
        }
      }
      var uni = totalValueTable/int.parse(widget.saveListModel[indexGlobal].qtd.text);
      widget.saveListModel[indexGlobal].valueTable = listGetProduct[index].total;
      widget.saveListModel[indexGlobal].discount = TextEditingController(text: 'R\$ ${totalDesc.toStringAsFixed(2).replaceAll('.', ',')}');
      widget.saveListModel[indexGlobal].valueUnit = TextEditingController(text: 'R\$ ${uni.toStringAsFixed(2).replaceAll('.', ',')}');
      widget.saveListModel[indexGlobal].total = listGetProduct[index].total;
      discount = 'R\$ ${totalDesc.toStringAsFixed(2).replaceAll('.', ',')}';
    });
  }
  discountUnitClient(int index,String field){
    double discountClient = double.parse(widget.saveListModel[indexGlobal].discount.text.replaceAll('R\$ ','').replaceAll(',', '.'));
    double valueUnit = double.parse(widget.saveListModel[indexGlobal].valueUnit.text.replaceAll('R\$ ','').replaceAll(',', '.'));
    double total = double.parse(widget.saveListModel[indexGlobal].total.replaceAll('R\$ ','').replaceAll(',', '.'));
    int quant = int.parse(widget.saveListModel[indexGlobal].qtd.text);

    setState(() {
      if(field=='discount'){
        valueFinal = 'R\$ '+ (total-discountClient).toStringAsFixed(2).replaceAll('.', ',');
      }else{
        double newTotal = valueUnit*quant;
        valueFinal = 'R\$ '+ newTotal.toStringAsFixed(2).replaceAll('.', ',');
        widget.saveListModel[indexGlobal].discount = TextEditingController(text: 'R\$ '+ (total-newTotal).toStringAsFixed(2).replaceAll('.', ','));
        discount = widget.saveListModel[indexGlobal].discount.text;
      }
    });
  }

  _createPdfClient()async{

    var nMontagem  = widget.order;
    var date   = widget.data;
    var filial   = widget.subsidiary;
    var cliente   = '${widget.codClient} - ${widget.client}';

    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString('N° de Montagem: $nMontagem',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(0,0,500,50));
    page.graphics.drawString('Emissão : $date',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(400,0,600,50));
    page.graphics.drawString('Filial : $filial',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(0,30,800,50));
    page.graphics.drawString('Cliente : $cliente',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(0,60,800,50));

    page.graphics.drawString('Qtd',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(0,100,50,50));
    page.graphics.drawString('Descrição',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(50,100,100,50));
    page.graphics.drawString('Valor Tabela',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(220,100,150,50));
    page.graphics.drawString('Desconto',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(300,100,150,50));
    page.graphics.drawString('Valor Unitário',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(360,100,150,50));
    page.graphics.drawString('Total',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(440,100,50,50));

    List<PDFModel> list=[];
    double top = 100;
    for(var i=0; widget.saveListModel.length>i;i++){
      top = top+30;
      double valorQtd = double.parse(widget.saveListModel[i].qtd.text);
      double valorTotal = double.parse(widget.saveListModel[i].total.replaceAll('R\$ ', '').replaceAll(',', '.'));
      double desc = double.parse(widget.saveListModel[i].discount.text.replaceAll('R\$ ', '').replaceAll(',', '.'));
      brutoGeral = brutoGeral + valorTotal;
      descGeral = desc + descGeral;
      liquidoGeral = brutoGeral-descGeral;
      double uni =  valorTotal/valorQtd;
      list.add(
          PDFModel(
              qtd: widget.saveListModel[i].qtd.text,
              descricao:  'Mang.(${widget.saveListModel[indexGlobal].cod.text}) ${widget.saveListModel[indexGlobal].diameterHose} ${widget.saveListModel[indexGlobal].pressureHose} ${widget.saveListModel[indexGlobal].descTerm1} / ${widget.saveListModel[indexGlobal].descTerm2} x ${double.parse(widget.saveListModel[indexGlobal].comp.text.isEmpty?'0':widget.saveListModel[indexGlobal].comp.text.replaceAll(',','.'))*1000}mm\nAplic: ${widget.saveListModel[indexGlobal].maker.text} - ${widget.saveListModel[indexGlobal].application.text}'.replaceAll("Â", '').replaceAll("null", ''),
              valorTabela: valueTable,
              desconto: discount,
              valorUnitario: 'R\$ ${uni.toStringAsFixed(2).replaceAll('.', ',')}',
              total: valueFinal
          )
      );
      page.graphics.drawString('${list[i].qtd}',PdfStandardFont(PdfFontFamily.helvetica, 10),bounds: Rect.fromLTWH(0,top,50,50));
      page.graphics.drawString('${list[i].descricao}',PdfStandardFont(PdfFontFamily.helvetica, 10),bounds: Rect.fromLTWH(50,top,150,50));
      page.graphics.drawString('${list[i].valorTabela}',PdfStandardFont(PdfFontFamily.helvetica, 10),bounds: Rect.fromLTWH(220,top,150,50));
      page.graphics.drawString('${list[i].desconto}',PdfStandardFont(PdfFontFamily.helvetica, 10),bounds: Rect.fromLTWH(300,top,150,50));
      page.graphics.drawString('${list[i].valorUnitario}',PdfStandardFont(PdfFontFamily.helvetica, 10),bounds: Rect.fromLTWH(360,top,150,50));
      page.graphics.drawString('${list[i].total}',PdfStandardFont(PdfFontFamily.helvetica, 10),bounds: Rect.fromLTWH(440,top,100,50));
    }


    page.graphics.drawString('Valor Bruto',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(360,top+90,150,50));
    page.graphics.drawString('R\$ ${brutoGeral.toStringAsFixed(2).replaceAll('.', ',')}',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(440,top+90,150,50));

    page.graphics.drawString('Desconto',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(360,top+120,150,50));
    page.graphics.drawString(discount,PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(440,top+120,150,50));

    page.graphics.drawString('Valor Líquido',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(360,top+150,150,50));
    page.graphics.drawString('R\$ ${liquidoGeral.toStringAsFixed(2).replaceAll('.', ',')}',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(440,top+150,150,50));

    bool time = false;
    List<int> bytes = await document.save().whenComplete((){
      document.dispose();
      setState(() {
        time=true;
      });
    });
    if(time){
      saveAndLaunhFile(bytes, 'n_montagem_$nMontagem.pdf');
    }
  }

  _createPdfTabela()async{

    var nMontagem  = widget.order;
    var date   = widget.data;
    var filial   = widget.subsidiary;
    var cliente   = '${widget.codClient} - ${widget.client}';

    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString('N° de Montagem: $nMontagem',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(0,0,500,50));
    page.graphics.drawString('Código: $codProduct',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(200,0,500,50));
    page.graphics.drawString('Emissão : $date',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(400,0,600,50));
    page.graphics.drawString('Filial : $filial',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(0,30,800,50));
    page.graphics.drawString('Cliente : $cliente',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(0,60,800,50));

    page.graphics.drawString('Código',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(0,100,50,50));
    page.graphics.drawString('Referência',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(60,100,110,50));
    page.graphics.drawString('Quantidade',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(130,100,150,50));
    page.graphics.drawString('Fabricante',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(220,100,150,50));
    page.graphics.drawString('Valor\nTabela',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(280,100,100,50));
    page.graphics.drawString('Desconto',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(330,100,60,50));
    page.graphics.drawString('Valor\nUnitário',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(400,100,80,50));
    page.graphics.drawString('Total',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(460,100,50,50));

    List<PDFTabelaModel> list=[];
    for(var i=0; widget.saveListProduct.length>i;i++){
     if(widget.saveListProduct[i].codUnit==codProduct){
       double valorQtd = double.parse(widget.saveListProduct[i].qtd);
       double valorTotal = double.parse(widget.saveListProduct[i].total.replaceAll('R\$ ', '').replaceAll(',', '.'));
       double desc = double.parse(widget.saveListProduct[i].controllerDiscount.text.replaceAll('R\$ ', '').replaceAll(',', '.'));
       brutoGeral = brutoGeral + valorTotal;
       descGeral = desc + descGeral;
       liquidoGeral = brutoGeral-descGeral;
       double uni =  valorTotal/valorQtd;
       list.add(
           PDFTabelaModel(
               cod: widget.saveListProduct[i].cod,
               ref: widget.saveListProduct[i].ref,
               qtd: widget.saveListProduct[i].qtd,
               fab: widget.saveListProduct[i].fab,
               valorTabela: widget.saveListProduct[i].valueTable,
               desconto: widget.saveListProduct[i].controllerDiscount.text,
               valorUnitario: widget.saveListProduct[i].controllerValueUnit.text,
               total: widget.saveListProduct[i].total
           )
       );
     }
    }
    double top = 100;
    for(var ind=0; list.length>ind;ind++){
      top = top+30;
      page.graphics.drawString('${list[ind].cod}',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(0,top,50,50));
      page.graphics.drawString('${list[ind].ref}',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(60,top,75,50));
      page.graphics.drawString('${list[ind].qtd}',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(160,top,100,50));
      page.graphics.drawString('${list[ind].fab}',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(220,top,100,50));
      page.graphics.drawString('${list[ind].valorTabela}',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(280,top,150,50));
      page.graphics.drawString('${list[ind].desconto}',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(330,top,150,50));
      page.graphics.drawString('${list[ind].valorUnitario}',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(400,top,150,50));
      page.graphics.drawString('${list[ind].total}',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(460,top,100,50));
    }

    page.graphics.drawString('Valor Bruto',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(360,top+90,150,50));
    page.graphics.drawString('R\$ ${brutoGeral.toStringAsFixed(2).replaceAll('.', ',')}',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(440,top+90,150,50));

    page.graphics.drawString('Desconto',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(360,top+120,150,50));
    page.graphics.drawString('R\$ ${descGeral.toStringAsFixed(2).replaceAll('.', ',')}',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(440,top+120,150,50));

    page.graphics.drawString('Valor Líquido',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(360,top+150,150,50));
    page.graphics.drawString('R\$ ${liquidoGeral.toStringAsFixed(2).replaceAll('.', ',')}',PdfStandardFont(PdfFontFamily.helvetica, 12),bounds: Rect.fromLTWH(440,top+150,150,50));

    bool time = false;
    List<int> bytes = await document.save().whenComplete((){
      document.dispose();
      setState(() {
        time=true;
      });
    });
    if(time){
      saveAndLaunhFile(bytes, 'cod_$codProduct.pdf');
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
                            if(_controllerDiscount.text.isNotEmpty){
                              descontosGeral();
                            }
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
                      child: ListView.builder(
                        itemCount: listGetProduct.length,
                        itemBuilder: (context,index){
                          return  indexGlobal != listGetProduct[index].indexAssembly || listGetProduct[index].qtd=='0'?
                          Container():
                            ListMaterial(
                              screenscreen:'seller',
                              hovercolor: Colors.white,
                              cod: listGetProduct[index].cod,
                              ref: listGetProduct[index].ref.toUpperCase(),
                              qtd: listGetProduct[index].qtd,
                              manufacturer: listGetProduct[index].fab.toUpperCase(),
                              valuetable: 'R\$ ${listGetProduct[index].valueTable.replaceAll('.', ',')}',
                              discount: listGetProduct[index].controllerDiscount,
                              valueUnit: listGetProduct[index].controllerValueUnit,
                              onChangeDiscount: (value){
                                discountUnit(index,'discount');
                              },
                              onChangeValueUnit:(value){
                                discountUnit(index,'valueUnit');
                              },
                              total:'${listGetProduct[index].total.replaceAll('.', ',')}' ,
                            );
                        }
                      ),
                    ),
                    SizedBox(height: 10),
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
                                          text: valueTable,
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
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 3),
                                          width: width*0.03,
                                          height: 25,
                                          alignment: Alignment.centerRight,
                                          child: TextFormField(
                                            controller: _controllerDiscuntOther,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'R\$ 0,00',
                                              hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14.0
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextCustom(
                                          text: valueFinal,
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
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AssemblyScreen(id: widget.idAssembly,))),
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
                                  'totalFinal': valueFinal,
                                  'status' : TextConst.orcamento
                                }).then((value) => Navigator.pushReplacementNamed(context, '/home'));
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
                          onPressed: ()async {
                            if(_controllerWhintor.text.length==8){
                              DocumentSnapshot snapshot = await db.collection("order").doc('order').get();
                              Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

                              int makerOrder = 0;
                              makerOrder = data?['makerOrder'];

                              if(makerOrder!=0){
                                db.collection('assembly').doc(widget.idAssembly).update({
                                  'status' : TextConst.aguardando,
                                  'whinthor': _controllerWhintor.text,
                                  'makerOrder' : makerOrder+1,
                                  'priority' : selectedPriority,
                                }).then((value) => db.collection('order').doc('order').update({
                                  'makerOrder' : makerOrder+1
                                })).then((value) => Navigator.pushReplacementNamed(context, '/home'));
                              }
                            }
                          },
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
                          onPressed: ()=>_createPdfTabela(),
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
                          text: '${widget.codClient} - ${widget.client}',
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
                              description: 'Mang.(${widget.saveListModel[index].cod.text}) ${widget.saveListModel[index].diameterHose} ${widget.saveListModel[index].pressureHose} ${widget.saveListModel[index].descTerm1} / ${widget.saveListModel[index].descTerm2} x ${double.parse(widget.saveListModel[index].comp.text.isEmpty?'0':widget.saveListModel[index].comp.text.replaceAll(',','.'))*1000}mm\nAplic: ${widget.saveListModel[index].maker.text} - ${widget.saveListModel[index].application.text}'.replaceAll("Â", '').replaceAll("null", ''),
                              valuetable: valueTable,
                              discount: widget.saveListModel[index].discount,
                              onChangedDiscount: (value){
                                discountUnitClient(index,'discount');
                              },
                              valueUnit: widget.saveListModel[index].valueUnit,
                              onChangedValueUnit:(value){
                                discountUnitClient(index,'valueUnit');
                              },
                              total: valueFinal,
                              onTap: (){
                                setState(() {
                                  codProduct = widget.saveListModel[index].cod.text;
                                  indexGlobal = index;
                                  refreshValues();
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
                                            text: valueTable,
                                            size: 14.0,
                                            color: PaletteColors.grey,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.normal,
                                          ),
                                          TextCustom(
                                            text: discount,
                                            size: 14.0,
                                            color: PaletteColors.grey,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.normal,
                                          ),
                                          TextCustom(
                                            text: valueFinal,
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
                            onPressed: (){
                              if(widget.saveListModel.length!=0){
                                _createPdfClient();
                              }else{
                                print('erro');
                              }
                            },
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
