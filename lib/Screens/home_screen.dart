import '../Utils/exports.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(70.0),
      child: Container(
        alignment: Alignment.topLeft,

          child: TextCustom(
            text: 'Olá Daniel,\nSelecione uma opção ao lado para prosseguir!',
            maxLines: 2,
            size: 20.0,
            color: PaletteColors.primaryColor,
            fontFamily: 'Nunito',

          ),

      ),
    );
  }
}
