import '../Utils/exports.dart';

class TextCustom extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontWeight;
  final textAlign;
  final maxLines;
  final fontFamily;

  TextCustom({
    required this.text,
    required this.fontFamily,
    this.size = 16.0,
    this.color = PaletteColors.primaryColor,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.maxLines = 1

  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: fontFamily,
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      ),
      minFontSize: size,
      maxLines: maxLines,
    );
  }
}