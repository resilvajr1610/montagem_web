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
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
      child: Container(
        width: 1000,
        height: 600,
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
            ),//Titulo
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
                SizedBox(width: 125),
                TextCustom(
                  text: 'Cliente',
                  size: 14.0,
                  color: PaletteColors.primaryColor,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.normal,
                ),
                SizedBox(width: 360),
                TextCustom(
                  text: 'Filial',
                  size: 14.0,
                  color: PaletteColors.primaryColor,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.normal,
                ),


              ],
            ),//Textos
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
            ),//Inputs
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 30),
                TextCustom(
                  text: 'Cod. Un',
                  size: 14.0,
                  color: PaletteColors.primaryColor,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(width: 30),
                TextCustom(
                  text: 'Referencia',
                  size: 14.0,
                  color: PaletteColors.primaryColor,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(width: 25),
                TextCustom(
                  text: 'Qtd',
                  size: 14.0,
                  color: PaletteColors.primaryColor,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(width: 20),
                TextCustom(
                  text: 'Maquina',
                  size: 14.0,
                  color: PaletteColors.primaryColor,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(width: 20),
                TextCustom(
                  text: 'Aplicação',
                  size: 14.0,
                  color: PaletteColors.primaryColor,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),



              ],
            )//Tags da tabela
          ],
        ),
      ),
    );
  }
}
