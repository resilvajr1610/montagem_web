import '../Utils/exports.dart';

class NavigationScreen extends StatefulWidget {
  final index;

  NavigationScreen({required this.index});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {


  final listRoutes = [HomeScreen(),AssemblyScreen(),HistoryScreen(),PendenciesScreen(),];
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {

    currentIndex = widget.index;
    final width = MediaQuery.of(context).size.width;

    return width> 600?Scaffold(
      backgroundColor: PaletteColors.backGrey,
      body: Flex(
        direction: Axis.horizontal,
        children: [

          Menu(index: currentIndex),
          Flexible(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        topLeft: Radius.circular(0)),
                    border: Border.all(color: PaletteColors.backGrey),
                    color: PaletteColors.backGrey
                ),

                child: listRoutes[currentIndex],
              ))
        ],
      ),
    ):Text('');


   
  }
}
