import '../Utils/exports.dart';

class AssemblyScreen extends StatefulWidget {
  const AssemblyScreen({Key? key}) : super(key: key);

  @override
  State<AssemblyScreen> createState() => _AssemblyScreenState();
}

class _AssemblyScreenState extends State<AssemblyScreen> {
  var _controllerDate = TextEditingController();
  var _controllerClient = TextEditingController();
  var _controllerClientName = TextEditingController();
  var _controllerAffiliation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
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
                      text: 'Montagem',
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
                    text: 'Data',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(width: 145),
                  TextCustom(
                    text: 'Cliente',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(width: 425),
                  TextCustom(
                    text: 'Filial',
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
                    controller: _controllerDate,
                    hint: '00/00/0000',
                    fonts: 14.0,
                    keyboardType: TextInputType.datetime,
                    width: width * 0.09,
                    sizeIcon: 0.01,
                    icons: Icons.height,
                    colorBorder: PaletteColors.inputGrey,
                    background: PaletteColors.inputGrey,
                  ),
                  SizedBox(width: 20),
                  InputRegister(
                    controller: _controllerClient,
                    hint: '00000',
                    fonts: 14.0,
                    keyboardType: TextInputType.number,
                    width: width * 0.05,
                    sizeIcon: 0.01,
                    icons: Icons.height,
                    colorBorder: PaletteColors.inputGrey,
                    background: PaletteColors.inputGrey,
                  ),
                  SizedBox(width: 15),
                  InputRegister(
                    controller: _controllerClientName,
                    hint: 'M M Empreendimentos',
                    fonts: 14.0,
                    keyboardType: TextInputType.datetime,
                    width: width * 0.2,
                    sizeIcon: 0.01,
                    icons: Icons.height,
                    colorBorder: PaletteColors.inputGrey,
                    background: PaletteColors.inputGrey,
                  ),
                  SizedBox(width: 30),
                  InputRegister(
                    controller: _controllerAffiliation,
                    hint: 'Belmap',
                    fonts: 14.0,
                    keyboardType: TextInputType.text,
                    width: width * 0.1,
                    sizeIcon: 0.01,
                    icons: Icons.height,
                    colorBorder: PaletteColors.inputGrey,
                    background: PaletteColors.inputGrey,
                  ),
                ],
              ), //Inputs
              SizedBox(height: 16),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: DataTable(
                        showCheckboxColumn: false,
                        dividerThickness: 0.0,
                        columnSpacing: 22.0,
                        dataRowHeight: 40.0,
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Cod. Un',
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
                        rows:  <DataRow>[
                          DataRow(
                            onSelectChanged: (value){

                            },
                            cells: <DataCell>[
                              DataCell(Text(
                                '0000000',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'SE41-A',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
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
                            onSelectChanged: (value){

                            },
                            cells: <DataCell>[
                              DataCell(Text(
                                '0000000',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'SE41-A',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
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
                            onSelectChanged: (value){

                            },
                            cells: <DataCell>[
                              DataCell(Text(
                                '0000000',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'SE41-A',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
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
                          onPressed: ()=> Navigator.popAndPushNamed(context, '/price'),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Material(
                    color: Colors.transparent,
                    child: Ink(
                      decoration: ShapeDecoration(
                        color: PaletteColors.primaryColor,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.control_point_duplicate,
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
                        onPressed: () {
                        },
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: 530),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonCustom(
                      widthCustom: 0.1,
                      heightCustom: 0.07,
                      text: "Gravar",
                      size: 12.0,
                      colorText: PaletteColors.white,
                      colorButton: PaletteColors.primaryColor,
                      colorBorder: PaletteColors.primaryColor,
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, '/home'),
                      font: 'Nunito',
                    ),
                  ),
                  SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonCustom(
                      widthCustom: 0.14,
                      heightCustom: 0.07,
                      text: "Resumo de montagem",
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
              SizedBox(height: 600)
            ],
          ),
        ),
      ),
    );
  }
}
