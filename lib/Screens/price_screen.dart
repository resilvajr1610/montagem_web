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
                    TextCustom(
                      text: 'Nº de montagem',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(width: 75),
                    TextCustom(
                      text: 'Orçamento Whintor',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(width: 75),
                    TextCustom(
                      text: 'Prioridade',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(width: 308),
                    TextCustom(
                      text: 'Desconto geral',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
                SizedBox(height: 4),//Textos
                Row(
                  children: [
                    SizedBox(width: 20),
                    InputRegister(
                      controller: _controllerNumberAssembly,
                      hint: '0000000',
                      fonts: 14.0,
                      keyboardType: TextInputType.number,
                      width: width * 0.09,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                    ),
                    SizedBox(width: 22),
                    InputRegister(
                      controller: _controllerWhintor,
                      hint: '00000000',
                      fonts: 14.0,
                      keyboardType: TextInputType.number,
                      width: width * 0.1,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                    ),
                    SizedBox(width: 35),
                    SizedBox(
                      height: 45,
                      width: 170,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: PaletteColors.inputGrey),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            iconSize: 40.0,
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
                    SizedBox(width: 195),
                    InputRegister(
                      controller: _controllerDiscount,
                      hint: '00%',
                      fonts: 14.0,
                      keyboardType: TextInputType.text,
                      width: width * 0.04,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                    ),
                    SizedBox(width: 10),
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 7.0),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: DataTable(
                          showCheckboxColumn: false,
                          dividerThickness: 0.0,
                          columnSpacing: 70.0,
                          dataRowHeight: 26.0,
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Código',
                                style: TextStyle(
                                    color: PaletteColors.primaryColor,
                                    fontFamily: 'Nunito',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Referência',
                                style: TextStyle(
                                    color: PaletteColors.primaryColor,
                                    fontFamily: 'Nunito',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Quantidade',
                                style: TextStyle(
                                    color: PaletteColors.primaryColor,
                                    fontFamily: 'Nunito',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Fabricante',
                                style: TextStyle(
                                    color: PaletteColors.primaryColor,
                                    fontFamily: 'Nunito',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Valor Tabela',
                                style: TextStyle(
                                    color: PaletteColors.primaryColor,
                                    fontFamily: 'Nunito',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Desconto',
                                style: TextStyle(
                                    color: PaletteColors.primaryColor,
                                    fontFamily: 'Nunito',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Valor Unitário',
                                style: TextStyle(
                                    color: PaletteColors.primaryColor,
                                    fontFamily: 'Nunito',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Total',
                                style: TextStyle(
                                    color: PaletteColors.primaryColor,
                                    fontFamily: 'Nunito',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: <DataRow>[
                            DataRow(
                              onSelectChanged: (value) {},
                              cells: <DataCell>[
                                DataCell(Text(
                                  '00000',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  '000000000000',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  '00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'NAC',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'R\$ 000,00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  '5%',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'R\$ 000,00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'R\$ 000,00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                              ],
                            ),
                            DataRow(
                              onSelectChanged: (value) {},
                              cells: <DataCell>[
                                DataCell(Text(
                                  '00000',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  '000000000000',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  '00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'NAC',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'R\$ 000,00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  '5%',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'R\$ 000,00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'R\$ 000,00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                              ],
                            ),
                            DataRow(
                              onSelectChanged: (value) {},
                              cells: <DataCell>[
                                DataCell(Text(
                                  '00000',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  '000000000000',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  '00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'NAC',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'R\$ 000,00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  '5%',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'R\$ 000,00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'R\$ 000,00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                              ],
                            ),
                            DataRow(
                              onSelectChanged: (value) {},
                              cells: <DataCell>[
                                DataCell(Text(
                                  '00000',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  '000000000000',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  '00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'NAC',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'R\$ 000,00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  '5%',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'R\$ 000,00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                                DataCell(Text(
                                  'R\$ 000,00',
                                  style: TextStyle(
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontSize: 12),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                        TextCustom(
                          text: '   Observação',
                          size: 14.0,
                          color: PaletteColors.primaryColor,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 75,
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
                                      textAlign: TextAlign.center,
                                    ),
                                    TextCustom(
                                      text: 'R\$ 000,00',
                                      size: 14.0,
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                    TextCustom(
                                      text: 'R\$ 000,00',
                                      size: 14.0,
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                    TextCustom(
                                      text: 'R\$ 000,00',
                                      size: 14.0,
                                      color: PaletteColors.grey,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center,
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
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 20),
                    TextCustom(
                      text: '29225-IPIRANGA COMERCIO E SERVIÇOS LTDA EPP',
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(width: 30),
                    TextCustom(
                      text: 'Qtd',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 25),
                    TextCustom(
                      text: 'Descrição',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 360),
                    TextCustom(
                      text: 'Valor Tabela',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 35),
                    TextCustom(
                      text: 'Desconto',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 35),
                    TextCustom(
                      text: 'Valor Unitário',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 35),
                    TextCustom(
                      text: 'Total',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      height: 65,
                      width: 1336,
                      decoration: BoxDecoration(
                        color: PaletteColors.lightGrey,
                      ),
                      child: ListTile(
                        onTap: () {},
                        title: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              TextCustom(
                                text: '1',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 35),
                              TextCustom(
                                text:
                                    '\nMang(ND12) 3/4 3120PS1 Fem GIR 0° / Macho 0° 1800mm\nAplic: D6N - Motor -> Bomba Principal',
                                maxLines: 4,
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(width: 46),
                              TextCustom(
                                text: 'R\$ 000,00',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 50),
                              TextCustom(
                                text: '5%',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 72),
                              TextCustom(
                                text: 'R\$ 000,00',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 60),
                              TextCustom(
                                text: 'R\$ 000,00',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
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
                                        textAlign: TextAlign.center,
                                      ),
                                      TextCustom(
                                        text: 'R\$ 000,00',
                                        size: 14.0,
                                        color: PaletteColors.grey,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.normal,
                                        textAlign: TextAlign.center,
                                      ),
                                      TextCustom(
                                        text: 'R\$ 000,00',
                                        size: 14.0,
                                        color: PaletteColors.grey,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.center,
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
