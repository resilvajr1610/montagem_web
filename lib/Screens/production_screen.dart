import '../Utils/exports.dart';

class ProductionScreen extends StatefulWidget {




  @override
  State<ProductionScreen> createState() => _ProductionScreenState();
}

class _ProductionScreenState extends State<ProductionScreen> {
  final listRoutes = [
    HomeScreen(),
    AssemblyScreen(),
    HistoryScreen(),
    PendenciesScreen(),
    ProductionScreen(),
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
                    TextCustom(
                      text: 'Data',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),

                    SizedBox(width: 150),
                    TextCustom(
                      text: 'Orçamento Whintor',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(width: 50),
                    TextCustom(
                      text: 'Ordem de Produção',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(width: 50),
                    TextCustom(
                      text: 'Prioridade',
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
                      hint: '00/00/0000 00:00',
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
                      hint: '00000000000000',
                      fonts: 14.0,
                      keyboardType: TextInputType.number,
                      width: width * 0.09,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                    ),
                    SizedBox(width: 20),
                    InputRegister(
                      controller: _controllerWhintor,
                      hint: '00000000',
                      fonts: 14.0,
                      keyboardType: TextInputType.number,
                      width: width * 0.08,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                    ),
                    SizedBox(width: 40),
                    SizedBox(
                      height: 45,
                      width: 175,
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
                    SizedBox(width: 360),
                    ButtonCustom(
                      widthCustom: 0.1,
                      heightCustom: 0.065,
                      text: "Finalizar Produção",
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
                SizedBox(height: 2),
                Row(
                  children: [
                    SizedBox(width: 30),
                    TextCustom(
                      text: 'Obs Vendedor',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 20),
                    InputRegister(
                      controller: _controllerNumberAssembly,
                      hint: 'aaaaabbbbbbbccccccdddddd',
                      fonts: 14.0,
                      keyboardType: TextInputType.number,
                      width: width * 0.46,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                    ),
                    SizedBox(width: 350),
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
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    SizedBox(width: 30),
                    TextCustom(
                      text: 'Obs sobra a Produção',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 20),
                    InputRegister(
                      controller: _controllerNumberAssembly,
                      hint: 'aaaaabbbbbbbccccccdddddd',
                      fonts: 14.0,
                      keyboardType: TextInputType.number,
                      width: width * 0.46,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.inputGrey,
                      background: PaletteColors.inputGrey,
                    ),
                    SizedBox(width: 350),
                    ButtonCustom(
                      widthCustom: 0.1,
                      heightCustom: 0.065,
                      text: "Cancelar Produção",
                      size: 14.0,
                      colorText: PaletteColors.white,
                      colorButton: PaletteColors.cancel,
                      colorBorder: PaletteColors.cancel,
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, '/home'),
                      font: 'Nunito',
                    ),
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
                    TextCustom(
                      text: 'Código',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 45),
                    TextCustom(
                      text: 'Referência',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 100),
                    TextCustom(
                      text: 'Quantidade',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 70),
                    TextCustom(
                      text: 'Fabricante',
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
                      height: 27,
                      width: 1336,

                      child: ListTile(
                        onTap: () {},
                        title: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              TextCustom(
                                text: '00000',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 45),
                              TextCustom(
                                text:'00000000000',

                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(width: 75),
                              TextCustom(
                                text: '00',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 125),
                              TextCustom(
                                text: 'NAC',
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
                Row(
                  children: [
                    Container(
                      height: 27,
                      width: 1336,

                      child: ListTile(
                        onTap: () {},
                        title: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              TextCustom(
                                text: '00000',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 45),
                              TextCustom(
                                text:'00000000000',

                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(width: 75),
                              TextCustom(
                                text: '00',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 125),
                              TextCustom(
                                text: 'NAC',
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
                Row(
                  children: [
                    Container(
                      height: 27,
                      width: 1336,

                      child: ListTile(
                        onTap: () {},
                        title: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              TextCustom(
                                text: '00000',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 45),
                              TextCustom(
                                text:'00000000000',

                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(width: 75),
                              TextCustom(
                                text: '00',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 125),
                              TextCustom(
                                text: 'NAC',
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
                Row(
                  children: [
                    Container(
                      height: 27,
                      width: 1336,

                      child: ListTile(
                        onTap: () {},
                        title: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              TextCustom(
                                text: '00000',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 45),
                              TextCustom(
                                text:'00000000000',

                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(width: 75),
                              TextCustom(
                                text: '00',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 125),
                              TextCustom(
                                text: 'NAC',
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
                Row(
                  children: [
                    Container(
                      height: 27,
                      width: 1336,

                      child: ListTile(
                        onTap: () {},
                        title: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              TextCustom(
                                text: '00000',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 45),
                              TextCustom(
                                text:'00000000000',

                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(width: 75),
                              TextCustom(
                                text: '00',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 125),
                              TextCustom(
                                text: 'NAC',
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
                Row(
                  children: [
                    Container(
                      height: 27,
                      width: 1336,

                      child: ListTile(
                        onTap: () {},
                        title: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              TextCustom(
                                text: '00000',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 45),
                              TextCustom(
                                text:'00000000000',

                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(width: 75),
                              TextCustom(
                                text: '00',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 125),
                              TextCustom(
                                text: 'NAC',
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
                Row(
                  children: [
                    Container(
                      height: 27,
                      width: 1336,

                      child: ListTile(
                        onTap: () {},
                        title: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              TextCustom(
                                text: '00000',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 45),
                              TextCustom(
                                text:'00000000000',

                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(width: 75),
                              TextCustom(
                                text: '00',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 125),
                              TextCustom(
                                text: 'NAC',
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
                    TextCustom(
                      text: 'Nº',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 30),
                    TextCustom(
                      text: 'Cod. Único',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 30),
                    TextCustom(
                      text: 'Qtd',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 30),
                    TextCustom(
                      text: 'Tipo Mang',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 15),
                    TextCustom(
                      text: 'Compri',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 30),
                    TextCustom(
                      text: 'T',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 30),
                    TextCustom(
                      text: 'Term. 1',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 50),
                    TextCustom(
                      text: 'Term. 2',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 50),
                    TextCustom(
                      text: 'Capa',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 30),
                    TextCustom(
                      text: 'Pos.',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 30),
                    TextCustom(
                      text: 'Adap. 1',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 30),
                    TextCustom(
                      text: 'Adap. 2',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 30),
                    TextCustom(
                      text: 'AN',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 30),
                    TextCustom(
                      text: 'MO',
                      size: 14.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),

                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 27,
                      width: 1336,

                      child: ListTile(
                        onTap: () {},
                        title: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              TextCustom(
                                text: '1',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 40),
                              TextCustom(
                                text:'SE41-A',

                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(width: 47),
                              TextCustom(
                                text: '3',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 45),
                              TextCustom(
                                text: 'R2-12',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 42),
                              TextCustom(
                                text: '0,54',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 42),
                              TextCustom(
                                text: 'PP',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 28),
                              TextCustom(
                                text: 'FSP-12-12',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 28),
                              TextCustom(
                                text: 'FSP-12-12',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 26),
                              TextCustom(
                                text: 'CP2-12',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 40),
                              TextCustom(
                                text: ' ',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 40),
                              TextCustom(
                                text: ' ',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 40),
                              TextCustom(
                                text: ' ',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 96),
                              TextCustom(
                                text: ' X ',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 40),
                              TextCustom(
                                text: ' ',
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
                Row(
                  children: [
                    Container(
                      height: 27,
                      width: 1336,

                      child: ListTile(
                        onTap: () {},
                        title: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              TextCustom(
                                text: '1',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 40),
                              TextCustom(
                                text:'SE41-A',

                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(width: 47),
                              TextCustom(
                                text: '3',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 45),
                              TextCustom(
                                text: 'R2-12',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 42),
                              TextCustom(
                                text: '0,54',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 42),
                              TextCustom(
                                text: 'PP',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 28),
                              TextCustom(
                                text: 'FSP-12-12',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 28),
                              TextCustom(
                                text: 'FSP-12-12',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 26),
                              TextCustom(
                                text: 'CP2-12',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 40),
                              TextCustom(
                                text: ' ',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 40),
                              TextCustom(
                                text: ' ',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 40),
                              TextCustom(
                                text: ' ',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 96),
                              TextCustom(
                                text: ' X ',
                                size: 14.0,
                                color: PaletteColors.grey,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 40),
                              TextCustom(
                                text: ' ',
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
                SizedBox(height: 100)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
