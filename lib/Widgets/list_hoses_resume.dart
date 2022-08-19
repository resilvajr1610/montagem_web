import '../Utils/exports.dart';

class ListHosesResume extends StatefulWidget {


  final qtd;
  final machine;
  final application;
  final type;
  final lenght;
  final t;
  final term1;
  final term2;
  final cape;
  final pos;
  final adap1;
  final adap2;
  final an;
  final mo;

  Color hovercolor;

  ListHosesResume({
    required this.hovercolor,
    this.application,
    this.machine,
    this.qtd,
    this.type,
    this.lenght,
    this.t,
    this.term1,
    this.term2,
    this.cape,
    this.pos,
    this.adap1,
    this.adap2,
    this.an,
    this.mo,
  });

  @override
  State<ListHosesResume> createState() => _ListHosesResumeState();
}

class _ListHosesResumeState extends State<ListHosesResume> {
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
                  SizedBox(width: 20),
                  Container(
                   width: width*0.03,
                    child: TextCustom(
                      text: widget.qtd,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      
                    ),
                  ),
                  Container(
                    width: width*0.05,
                    child: TextCustom(
                      text: widget.machine,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      
                    ),
                  ),
                  Container(
                    width: width*0.12,
                    child: TextCustom(
                      text: widget.application,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      
                    ),
                  ),
                  Container(
                   width: width*0.05,
                    child: TextCustom(
                      text: widget.type,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      
                    ),
                  ),
                  Container(
                   width: width*0.04,
                    child: TextCustom(
                      text: widget.lenght,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      
                    ),
                  ),
                  Container(
                   width: width*0.02,
                    child: TextCustom(
                      text: widget.t,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      
                    ),
                  ),
                  Container(
                   width: width*0.055,
                    child: TextCustom(
                      text: widget.term1,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      
                    ),
                  ),
                  Container(
                   width: width*0.055,
                    child: TextCustom(
                      text: widget.term2,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      
                    ),
                  ),
                  Container(
                   width: width*0.04,
                    child: TextCustom(
                      text: widget.cape,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      
                    ),
                  ),
                  Container(
                   width: width*0.04,
                    child: TextCustom(
                      text: widget.pos,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      
                    ),
                  ),
                  Container(
                   width: width*0.04,
                    child: TextCustom(
                      text: widget.adap1,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      
                    ),
                  ),
                  Container(
                   width: width*0.04,
                    child: TextCustom(
                      text: widget.adap2,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      
                    ),
                  ),
                  Container(
                   width: width*0.02,
                    child: TextCustom(
                      text: widget.an,
                      size: 14.0,
                      color: PaletteColors.grey,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      
                    ),
                  ),
                  Container(
                   width: width*0.02,
                    child: TextCustom(
                      text: widget.mo,
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
