import '../Utils/exports.dart';

class ButtonCustom extends StatelessWidget{
  final VoidCallback onPressed;
  final String text;
  final double size;
  final Color colorButton;
  final Color colorText;
  final Color colorBorder;
  final widthCustom;
  final heightCustom;
  final font;

  const ButtonCustom(
  {Key? key,
    this.font = 'Nunito',
    required this.onPressed,
    required this.text,
    this.size = 20.0,
    this.colorButton = PaletteColors.primaryColor,
    this.colorText = PaletteColors.white,
    this.colorBorder = PaletteColors.primaryColor,
    this.widthCustom = 1.0,
    this.heightCustom = 1.0
}) : super(key: key);
  @override
  Widget build (BuildContext context) {
    double width =MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: colorButton,
        minimumSize: Size(width*widthCustom! , height*heightCustom!),
        side:  BorderSide(width: 2,color : colorBorder,),
      ),
      onPressed: onPressed,
      child: Text(text,
        style: TextStyle(fontFamily: font, color: colorText,
        fontSize: size,fontWeight: FontWeight.bold
        ),
      ) ,
    );
  }
}