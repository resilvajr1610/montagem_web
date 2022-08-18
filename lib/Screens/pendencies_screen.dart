import '../Utils/exports.dart';

class PendenciesScreen extends StatefulWidget {
  const PendenciesScreen({Key? key}) : super(key: key);

  @override
  State<PendenciesScreen> createState() => _PendenciesScreenState();
}

class _PendenciesScreenState extends State<PendenciesScreen> {

  int selectedText = 0;
  List<ListButtomModel> row1 = [
    ListButtomModel(
        order: '0000000',
        whintor: '00000000000',
        date: '00/00/0000 00:00',
        client: '29225 - IPIRANGA COMERCIO E SERVIÇOS LTDA ',
        priority: 'Cliente Balcão',
        status: 'Aguardando montador',
        ButtomShow: false),
  ];
  List<ListButtomModel> row2 = [
    ListButtomModel(
        order: '0000000',
        whintor: '00000000000',
        date: '00/00/0000 00:00',
        client: '29225 - IPIRANGA COMERCIO E SERVIÇOS LTDA ',
        priority: 'Alta',
        status: 'Aguardando montador',
        ButtomShow: false),
  ];
  List<ListButtomModel> row3 = [
    ListButtomModel(
        order: '0000000',
        whintor: '00000000000',
        date: '00/00/0000 00:00',
        client: '29225 - IPIRANGA COMERCIO E SERVIÇOS LTDA ',
        priority: 'Média',
        status: 'Aguardando montador',
        ButtomShow: false),
  ];
  List<ListButtomModel> row4 = [
    ListButtomModel(
        order: '0000000',
        whintor: '00000000000',
        date: '00/00/0000 00:00',
        client: '29225 - IPIRANGA COMERCIO E SERVIÇOS LTDA ',
        priority: 'Baixa',
        status: 'Aguardando montador',
        ButtomShow: false),
  ];
  List<ListButtomModel> row5 = [
    ListButtomModel(
        order: '0000000',
        whintor: '00000000000',
        date: '00/00/0000 00:00',
        client: '29225 - IPIRANGA COMERCIO E SERVIÇOS LTDA ',
        priority: 'Baixa',
        status: 'Aguardando montador',
        ButtomShow: false),
  ];



  @override
  Widget build(BuildContext context) {




    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
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
              SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(width: 30),
                  TextCustom(
                    text: 'Montagens pendentes de produção',
                    size: 14.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ), //Textos
              SizedBox(height: 35),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: TextCustom(
                      text: 'Ordem de Produção',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: TextCustom(
                      text: 'Orçamento Whintor',
                      maxLines: 4,
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: TextCustom(
                      text: 'Data/ Hora',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: TextCustom(
                      text: 'Cliente',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 297),
                    child: TextCustom(
                      text: 'Prioridade',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: TextCustom(
                      text: 'Status',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              ListTileButtom(
                order: row1[0].order,
                whintor: row1[0].whintor,
                date: row1[0].date,
                client: row1[0].client,
                priority: row1[0].priority,
                status: row1[0].status,
                showButtom: row1[0].ButtomShow,
                onTap: () {
                  setState(() {
                    if (selectedText == 0) {
                      selectedText = selectedText + 1;
                      row1[0].ButtomShow = true;
                    } else {
                      selectedText = selectedText - 1;
                      row1[0].ButtomShow = false;
                    }
                  });
                },
                hovercolor: Colors.white,
              ),
              ListTileButtom(
                order: (row2[0].order),
                whintor: (row2[0].whintor),
                date: (row2[0].date),
                client: (row2[0].client),
                priority: (row2[0].priority),
                status: (row2[0].status),
                showButtom: row2[0].ButtomShow,
                onTap: () {
                  setState(() {
                    if (selectedText == 0) {
                      selectedText = selectedText + 1;
                      row2[0].ButtomShow = true;
                    } else {
                      selectedText = selectedText - 1;
                      row2[0].ButtomShow = false;
                    }
                  });
                },
                hovercolor: Colors.white,
              ),
              ListTileButtom(
                order: (row3[0].order),
                whintor: (row3[0].whintor),
                date: (row3[0].date),
                client: (row3[0].client),
                priority: (row3[0].priority),
                status: (row3[0].status),
                showButtom: row3[0].ButtomShow,
                onTap: () {
                  setState(() {
                    if (selectedText == 0) {
                      selectedText = selectedText + 1;
                      row3[0].ButtomShow = true;
                    } else {
                      selectedText = selectedText - 1;
                      row3[0].ButtomShow = false;
                    }
                  });
                },
                hovercolor: Colors.white,
              ),
              ListTileButtom(
                order: (row4[0].order),
                whintor: (row4[0].whintor),
                date: (row4[0].date),
                client: (row4[0].client),
                priority: (row4[0].priority),
                status: (row4[0].status),
                showButtom: row4[0].ButtomShow,
                onTap: () {
                  setState(() {
                    if (selectedText == 0) {
                      selectedText = selectedText + 1;
                      row4[0].ButtomShow = true;
                    } else {
                      selectedText = selectedText - 1;
                      row4[0].ButtomShow = false;
                    }
                  });
                },
                hovercolor: Colors.white,
              ),
              ListTileButtom(
                order: (row5[0].order),
                whintor: (row5[0].whintor),
                date: (row5[0].date),
                client: (row5[0].client),
                priority: (row5[0].priority),
                status: (row5[0].status),
                showButtom: row5[0].ButtomShow,
                onTap: () {
                  setState(() {
                    if (selectedText == 0) {
                      selectedText = selectedText + 1;
                      row5[0].ButtomShow = true;
                    } else {
                      selectedText = selectedText - 1;
                      row5[0].ButtomShow = false;
                    }
                  });
                },
                hovercolor: Colors.white,
              ),
              SizedBox(height: 800),
            ],
          ),
        ),
      ),
    );
  }
}
