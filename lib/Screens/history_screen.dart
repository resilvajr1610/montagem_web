import '../Utils/exports.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedText = 0;
  List<ListIconModel> items = [
    ListIconModel(date: '00/00/0000',assembly: '000000',
        client: 'IPIRANGA COMÉRCIO E SERVIÇOS LTDA',
        number: '00000000', winthor: '000000000', iconShow: false),
    ListIconModel(date: '00/00/0000',assembly: '000000',
        client: 'IPIRANGA COMÉRCIO E SERVIÇOS LTDA',
        number: '00000000', winthor: '000000000', iconShow: false),
    ListIconModel(date: '00/00/0000',assembly: '000000',
        client: 'IPIRANGA COMÉRCIO E SERVIÇOS LTDA',
        number: '00000000', winthor: '000000000', iconShow: false),

  ];
  bool selectedValue = false;

  var _controllerNumberAssembly = TextEditingController();
  var _controllerWhintor = TextEditingController();
  var _controllerNumberOp = TextEditingController();
  var _controllerClient = TextEditingController();

  var _controllerReference = TextEditingController();
  var _controllerInitialDate = TextEditingController();
  var _controllerFinalDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 100.0),
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
                  TextCustom(
                    text: 'Nº de montagem',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(width: 57),
                  TextCustom(
                    text: 'Orçamento Whintor',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(width: 54),
                  TextCustom(
                    text: 'Número OP',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(width: 39),
                  TextCustom(
                    text: 'Cliente',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ), //Textos
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
                  SizedBox(width: 5),
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
                  SizedBox(width: 5),
                  InputRegister(
                    controller: _controllerNumberOp,
                    hint: '000000',
                    fonts: 14.0,
                    keyboardType: TextInputType.number,
                    width: width * 0.06,
                    sizeIcon: 0.01,
                    icons: Icons.height,
                    colorBorder: PaletteColors.inputGrey,
                    background: PaletteColors.inputGrey,
                  ),
                  SizedBox(width: 5),
                  InputRegister(
                    controller: _controllerClient,
                    hint: 'IPIRANGA COMÉRCIO E SERVIÇOS LTDA',
                    fonts: 14.0,
                    keyboardType: TextInputType.text,
                    width: width * 0.25,
                    sizeIcon: 0.01,
                    icons: Icons.height,
                    colorBorder: PaletteColors.inputGrey,
                    background: PaletteColors.inputGrey,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 30),
                  TextCustom(
                    text: 'Referência',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(width: 98),
                  TextCustom(
                    text: 'Data inicial',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(width: 90),
                  TextCustom(
                    text: 'Data final',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ), //Textos
              Row(
                children: [
                  SizedBox(width: 20),
                  InputRegister(
                    controller: _controllerReference,
                    hint: '0000000',
                    fonts: 14.0,
                    keyboardType: TextInputType.number,
                    width: width * 0.09,
                    sizeIcon: 0.01,
                    icons: Icons.height,
                    colorBorder: PaletteColors.inputGrey,
                    background: PaletteColors.inputGrey,
                  ),
                  SizedBox(width: 5),
                  InputRegister(
                    controller: _controllerInitialDate,
                    hint: '00/00/0000',
                    fonts: 14.0,
                    keyboardType: TextInputType.datetime,
                    width: width * 0.09,
                    sizeIcon: 0.01,
                    icons: Icons.height,
                    colorBorder: PaletteColors.inputGrey,
                    background: PaletteColors.inputGrey,
                  ),
                  SizedBox(width: 5),
                  InputRegister(
                    controller: _controllerFinalDate,
                    hint: '00/00/0000',
                    fonts: 14.0,
                    keyboardType: TextInputType.datetime,
                    width: width * 0.08,
                    sizeIcon: 0.01,
                    icons: Icons.height,
                    colorBorder: PaletteColors.inputGrey,
                    background: PaletteColors.inputGrey,
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
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, '/home'),
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
                  SizedBox(width: 30),
                  TextCustom(
                    text: 'Data',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 70),
                  TextCustom(
                    text: 'N° da montagem',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 45),
                  TextCustom(
                    text: 'Cliente',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 275),
                  TextCustom(
                    text: 'N° OP',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 50),
                  TextCustom(
                    text: 'Orçamento Winthor',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
              ListTileCustom(
                date: items[0].date,
                assembly: items[0].assembly,
                client: items[0].client,
                number: items[0].number,
                winthor: items[0].winthor,

                showIcons: items[0].iconShow,
                onTap: () {
                  setState(() {
                    if (selectedText == 0) {
                      selectedText = selectedText + 1;
                      items[0].iconShow = true;
                    } else {
                      selectedText = selectedText - 1;
                      items[0].iconShow = false;
                    }
                  });
                },
                hovercolor: PaletteColors.white,
              ),
              ListTileCustom(
                date: items[1].date,
                assembly: items[1].assembly,
                client: items[1].client,
                number: items[1].number,
                winthor: items[1].winthor,

                showIcons: items[1].iconShow,
                onTap: () {
                  setState(() {
                    if (selectedText == 0) {
                      selectedText = selectedText + 1;
                      items[1].iconShow = true;
                    } else {
                      selectedText = selectedText - 1;
                      items[1].iconShow = false;
                    }
                  });
                },
                hovercolor: PaletteColors.white,
              ),
              ListTileCustom(
                date: items[2].date,
                assembly: items[2].assembly,
                client: items[2].client,
                number: items[2].number,
                winthor: items[2].winthor,

                showIcons: items[2].iconShow,
                onTap: () {
                  setState(() {
                    if (selectedText == 0) {
                      selectedText = selectedText + 1;
                      items[2].iconShow = true;
                    } else {
                      selectedText = selectedText - 1;
                      items[2].iconShow = false;
                    }
                  });
                },
                hovercolor: PaletteColors.white,
              ),
              SizedBox(height: 40),
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 7.0),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: DataTable(
                        dividerThickness: 0.0,
                        columnSpacing: 12.0,
                        dataRowHeight: 30.0,
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Qtd',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Máquina',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Aplicação',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Tipo Mang',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Compri',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'T',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Term. 1',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Term. 2',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Capa',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Pos.',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Adap. 1',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Adap. 2',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'AN',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'MO',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        rows: const <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text(
                                '3',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'D6N',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'Motor-> Bomba Principal',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'R2012',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '0,54',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'PP',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'FSP-12-12',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'FSP-12-12',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'CP2-12',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'X',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text(
                                '3',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'D6N',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'Motor-> Bomba Principal',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'R2012',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '0,54',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'PP',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'FSP-12-12',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'FSP-12-12',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'CP2-12',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'X',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text(
                                '3',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'D6N',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'Motor-> Bomba Principal',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'R2012',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '0,54',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'PP',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'FSP-12-12',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'FSP-12-12',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'CP2-12',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'X',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '',
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
              SizedBox(height: 800)
            ],
          ),
        ),
      ),
    );
  }
}
