import '../Utils/exports.dart';

class ListClient extends StatefulWidget {

  final qtd;
  final description;
  final valuetable;
  final discount;
  final value;
  final total;
  final onTap;
  Color hovercolor;

  ListClient({
    required this.hovercolor,
    this.qtd,
    this.description,
    this.valuetable,
    this.discount,
    this.value,
    this.total,
    this.onTap
  });

  @override
  State<ListClient> createState() => _ListClientState();
}

class _ListClientState extends State<ListClient> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MouseRegion(
      onEnter: (event) =>
          setState(() => widget.hovercolor = PaletteColors.selectedColor),
      onExit: (event) =>
          setState(() => widget.hovercolor = PaletteColors.white),
      child: Container(
        color: widget.hovercolor,
        child: ListTile(
          onTap: widget.onTap,
          title: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 15),
                  Container(
                    width: width*0.07,
                    child: TextCustom(
                      text: widget.qtd,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: width*0.27,
                    child: TextCustom(
                      text: widget.description,
                      maxLines: 3,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,

                    ),
                  ),
                  Container(
                    width: width*0.08,
                    child: TextCustom(
                      text: widget.valuetable,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,

                    ),
                  ),
                  Container(
                    width: width*0.07,
                    child: TextCustom(
                      text: widget.discount,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,

                    ),
                  ),
                  Container(
                    width: width*0.07,
                    child: TextCustom(
                      text: widget.value,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,

                    ),
                  ),
                  Container(
                    width: width*0.07,
                    child: TextCustom(
                      text: widget.total,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,

                    ),
                  ),
                  SizedBox(width: width * 0.01),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  onEnter(_) {
    setState(() => widget.hovercolor = PaletteColors.selectedColor);
  }

  onExit(_) {
    setState(() => widget.hovercolor = PaletteColors.white);
  }
}
