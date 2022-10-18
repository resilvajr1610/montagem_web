import '../Utils/exports.dart';

class ListMaterial extends StatefulWidget {


  final String cod;
  final String ref;
  final String qtd;
  final String manufacturer;
  final String valuetable;
  final TextEditingController discount;
  final TextEditingController valueUnit;
  final String total;
  Color hovercolor;
  final bool enable;

  ListMaterial({
    required this.hovercolor,
    this.qtd='',
    this.ref='',
    this.cod='',
    this.manufacturer='',
    this.valuetable='',
    required this.discount,
    required this.valueUnit,
    this.total='',
    this.enable = true
  });

  @override
  State<ListMaterial> createState() => _ListMaterialState();
}

class _ListMaterialState extends State<ListMaterial> {
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
          title: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 15),
                  Container(
                    width: width*0.09,
                    child: TextCustom(
                      text: widget.cod,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,

                    ),
                  ),
                  Container(
                    width: width*0.11,
                    child: TextCustom(
                      text: widget.ref,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,

                    ),
                  ),
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
                    width: width*0.07,
                    child: TextCustom(
                      text: widget.manufacturer,
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
                    child: TextFormField(
                      enabled: widget.enable,
                      controller: widget.discount,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'R\$ 00,00',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width*0.07,
                    child: TextFormField(
                      enabled: widget.enable,
                      controller: widget.valueUnit,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'R\$ 00,00',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
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
