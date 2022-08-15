import 'package:montagem_web/Widgets/list_tile_hover.dart';

import '../Utils/exports.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  final list = ['000000000', 'SE41-A', '3', 'D6N', 'Motor -> Bomba Principal'
      'R2-12', '0,54' , 'PP' , 'FSP-12-12', 'FSP-12-12','CP2-12',' ', ' ' ,' ','X',''
  ];



  var _controllerDate = TextEditingController();
  var _controllerClient = TextEditingController();
  var _controllerClientName = TextEditingController();
  var _controllerAffiliation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final heigth = MediaQuery
        .of(context)
        .size
        .height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
      child: Container(
        width: 333,
        height: 333,
        constraints: BoxConstraints(
          maxHeight: 300,
          minHeight: 300,
          minWidth: 300,
          maxWidth: 300,
        ),


        child:
        Row(
          children: [

            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Age',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Role',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: const <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Sarah')),
                    DataCell(Text('19')),
                    DataCell(Text('Student')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Janine')),
                    DataCell(Text('43')),
                    DataCell(Text('Professor')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('William')),
                    DataCell(Text('27')),
                    DataCell(Text('Associate Professor')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
