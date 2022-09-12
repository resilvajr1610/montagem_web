import 'package:montagem_web/Widgets/list_client.dart';
import 'package:montagem_web/Widgets/list_material.dart';

import '../Utils/exports.dart';

class PriceScreen extends StatefulWidget {
  final index;

  PriceScreen({required this.index});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  final listRoutes = [
    HomeScreen(),
    AssemblyScreen(),
    HistoryScreen(),
    PendenciesScreen(),
    PriceScreen(index: 4),
  ];
  var currentIndex = 0;

  List<String> priority = ['Cliente Balcão', 'Alta', 'Média', 'Baixa'];
  String? selectedPriority = 'Cliente Balcão';

  var _controllerNumberAssembly = TextEditingController();
  var _controllerWhintor = TextEditingController();
  var _controllerPriority = TextEditingController();
  var _controllerDiscount = TextEditingController();
  var _controllerObservation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    currentIndex = widget.index;
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 100.0),
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
                        controller: _controllerNumberAssembly,
                        hint: '0000000',
                        fonts: 14.0,
                        keyboardType: TextInputType.number,
                        width: width * 0.08,
                        sizeIcon: 0.01,
                        icons: Icons.height,
                        colorBorder: PaletteColors.inputGrey,
                        background: PaletteColors.inputGrey,
                        onChanged: (){},
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
                        onChanged: (){},
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
                        onChanged: (){},
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
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, '/home'),
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
                ListMaterial(
                  hovercolor: Colors.white,
                  cod: '00000',
                  ref: '00000000000',
                  qtd: '00',
                  manufacturer: 'NAC',
                  valuetable: 'R\$ 000.00',
                  discount: '5%',
                  value: 'R\$ 000.00',
                  total:'R\$ 000.00' ,
                ),
                ListMaterial(
                  hovercolor: Colors.white,
                  cod: '00000',
                  ref: '00000000000',
                  qtd: '00',
                  manufacturer: 'NAC',
                  valuetable: 'R\$ 000.00',
                  discount: '5%',
                  value: 'R\$ 000.00',
                  total:'R\$ 000.00' ,
                ),
                ListMaterial(
                  hovercolor: Colors.white,
                  cod: '00000',
                  ref: '00000000000',
                  qtd: '00',
                  manufacturer: 'NAC',
                  valuetable: 'R\$ 000.00',
                  discount: '5%',
                  value: 'R\$ 000.00',
                  total:'R\$ 000.00' ,
                ),
                SizedBox(height: 10),
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
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
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
                            controller: _controllerDiscount,
                            hint: 'aaaabbbbbcccddddeeee',
                            fonts: 14.0,
                            keyboardType: TextInputType.text,
                            width: width * 0.5,
                            sizeIcon: 0.01,
                            icons: Icons.height,
                            colorBorder: PaletteColors.inputGrey,
                            background: PaletteColors.inputGrey,
                            onChanged: (){},
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
                          Navigator.popAndPushNamed(context, '/home'),
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
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, '/home'),
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
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, '/home'),
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
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, '/home'),
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
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, '/home'),
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
                      text: '29225-IPIRANGA COMERCIO E SERVIÇOS LTDA EPP',
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
                ListClient(
                  hovercolor: Colors.white,
                  qtd: '00',
                  description: '\nMang.(ND12) 3/4 3120PSI Fem GIR 0º / Macho 0º * 1800mm\nAplic: D6N - Motor -> Bomba Principal',
                  valuetable: 'R\$ 000.00',
                  discount: '5%',
                  value: 'R\$ 000.00',
                  total:'R\$ 000.00' ,
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
                        onPressed: () =>
                            Navigator.popAndPushNamed(context, '/home'),
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
    );
  }
}
