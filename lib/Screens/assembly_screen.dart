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

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: PaletteColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                TextCustom(
                  text: 'Montagem',
                  size: 20.0,
                  color: PaletteColors.primaryColor,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,

                ),
              ],
            )
          ],

        ),

      ),
    );
  }
}
