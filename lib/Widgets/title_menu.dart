import '../Utils/exports.dart';

class TitleMenu extends StatelessWidget {

  final text;
  final icon;
  final select;
  final index;

  TitleMenu({
    required this.text,
    required this.icon,
    required this.index,
    this.select = false,
  });

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: ()=> Navigator.pushReplacement(context, PageTransition(
          child: NavigationScreen(index: index),
          type: PageTransitionType.fade,
          duration: Duration.zero
      )),
      child: Container(
        margin: EdgeInsets.only(left: 20,bottom: 15),
        width: width,
        height: height*0.07,
        decoration: BoxDecoration(
          color: select ? PaletteColors.backGrey: PaletteColors.primaryColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)),
          border: Border.all(color: select ? PaletteColors.backGrey : PaletteColors.primaryColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 15),
            Icon(icon, color: select ? PaletteColors.primaryColor : PaletteColors.white),
            SizedBox(width: 10),
            Container(
              width: width*0.08,
              child: TextCustom(
                size: 14.0,
                text: text,
                color: select ? PaletteColors.primaryColor : PaletteColors.white,
                textAlign: TextAlign.start,
                fontWeight: select ? FontWeight.bold : FontWeight.normal, fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }
}