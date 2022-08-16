import '../Utils/exports.dart';

class PendenciesScreen extends StatefulWidget {
  const PendenciesScreen({Key? key}) : super(key: key);

  @override
  State<PendenciesScreen> createState() => _PendenciesScreenState();
}

class _PendenciesScreenState extends State<PendenciesScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    int selectedText = 0;


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
              SizedBox(height: 4),
              Row(
                children: [
                  SizedBox(width: 30),
                  TextCustom(
                    text: 'Montagens pendentes de produção',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                  ),

                ],
              ), //Textos

              SizedBox(height: 10),

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
                        columnSpacing: 40.0,
                        dataRowHeight: 30.0,
                        columns:  <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Ordem de Produção',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(

                            label: Text(
                              'Orçamento Whintor',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Data/Hora',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Cliente',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Prioridade',
                              style: TextStyle(
                                  color: PaletteColors.primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Status',
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
                              setState(() {
                                if(selectedText==0){
                                  selectedText= selectedText+1 ;
                                  ButtonCustom(
                                    widthCustom: 0.20,
                                    heightCustom: 0.07,
                                    text: "Iniciar Produção",
                                    size: 14.0,
                                    colorText: PaletteColors.white,
                                    colorButton: PaletteColors.primaryColor,
                                    colorBorder: PaletteColors.primaryColor,
                                    onPressed: () =>
                                        Navigator.popAndPushNamed(context, '/home'),
                                    font: 'Nunito',
                                  );
                                }
                                else{
                                  selectedText= selectedText-1;
                                  
                                }
                              });
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
                                '000000000',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '00/00/0000 00:00',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '29225 - IPIRANGA COMÉRCIO E SERVIÇOS LTDA',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'Cliente Balcão',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'Aguardando montador',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                            ],
                          ),
                          DataRow(
                            onSelectChanged: (value){
                              setState(() {
                                if(selectedText==0){
                                  selectedText= selectedText+1 ;
                                  ButtonCustom(
                                    widthCustom: 0.20,
                                    heightCustom: 0.07,
                                    text: "Iniciar Produção",
                                    size: 14.0,
                                    colorText: PaletteColors.white,
                                    colorButton: PaletteColors.primaryColor,
                                    colorBorder: PaletteColors.primaryColor,
                                    onPressed: () =>
                                        Navigator.popAndPushNamed(context, '/home'),
                                    font: 'Nunito',
                                  );
                                }
                                else{
                                  selectedText= selectedText-1;

                                }
                              });
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
                                '000000000',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '00/00/0000 00:00',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '29225 - IPIRANGA COMÉRCIO E SERVIÇOS LTDA',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'Alta',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'Aguardando montador',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                            ],
                          ),
                          DataRow(
                            onSelectChanged: (value){
                              setState(() {
                                if(selectedText==0){
                                  selectedText= selectedText+1 ;
                                  ButtonCustom(
                                    widthCustom: 0.20,
                                    heightCustom: 0.07,
                                    text: "Iniciar Produção",
                                    size: 14.0,
                                    colorText: PaletteColors.white,
                                    colorButton: PaletteColors.primaryColor,
                                    colorBorder: PaletteColors.primaryColor,
                                    onPressed: () =>
                                        Navigator.popAndPushNamed(context, '/home'),
                                    font: 'Nunito',
                                  );
                                }
                                else{
                                  selectedText= selectedText-1;

                                }
                              });
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
                                '000000000',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '00/00/0000 00:00',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '29225 - IPIRANGA COMÉRCIO E SERVIÇOS LTDA',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'Média',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'Em produção',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                            ],
                          ),
                          DataRow(
                            onSelectChanged: (value){
                              setState(() {
                                if(selectedText==0){
                                  selectedText= selectedText+1 ;
                                  ButtonCustom(
                                    widthCustom: 0.20,
                                    heightCustom: 0.07,
                                    text: "Iniciar Produção",
                                    size: 14.0,
                                    colorText: PaletteColors.white,
                                    colorButton: PaletteColors.primaryColor,
                                    colorBorder: PaletteColors.primaryColor,
                                    onPressed: () =>
                                        Navigator.popAndPushNamed(context, '/home'),
                                    font: 'Nunito',
                                  );
                                }
                                else{
                                  selectedText= selectedText-1;

                                }
                              });
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
                                '000000000',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '00/00/0000 00:00',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '29225 - IPIRANGA COMÉRCIO E SERVIÇOS LTDA',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'Baixa',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'Em produção',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                            ],
                          ),
                          DataRow(
                            onSelectChanged: (value){
                              setState(() {
                                if(selectedText==0){
                                  selectedText= selectedText+1 ;
                                  ButtonCustom(
                                    widthCustom: 0.20,
                                    heightCustom: 0.07,
                                    text: "Iniciar Produção",
                                    size: 14.0,
                                    colorText: PaletteColors.white,
                                    colorButton: PaletteColors.primaryColor,
                                    colorBorder: PaletteColors.primaryColor,
                                    onPressed: () =>
                                        Navigator.popAndPushNamed(context, '/home'),
                                    font: 'Nunito',
                                  );
                                }
                                else{
                                  selectedText= selectedText-1;

                                }
                              });
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
                                '000000000',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '00/00/0000 00:00',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                '29225 - IPIRANGA COMÉRCIO E SERVIÇOS LTDA',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'Baixa',
                                style: TextStyle(
                                    color: PaletteColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12),
                              )),
                              DataCell(Text(
                                'Em produção',
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
