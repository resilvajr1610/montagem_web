import '../Utils/exports.dart';
import '../Utils/text_const.dart';

class ListTileCustom extends StatefulWidget {
  final onTap;
  final date;
  final assembly;
  final client;
  final number;
  final winthor;
  final status;
  Color hovercolor;
  bool showIcons;
  final onPressedShow;
  final onPressedEdit;
  final onPressedDuplicated;

  ListTileCustom({
    required this.hovercolor,
    required this.date,
    required this.assembly,
    required this.client,
    required this.number,
    required this.winthor,
    required this.status,
    required this.onTap,
    this.showIcons = false,
    required this.onPressedShow,
    required this.onPressedEdit,
    required this.onPressedDuplicated,
  });

  @override
  State<ListTileCustom> createState() => _ListTileCustomState();
}

class _ListTileCustomState extends State<ListTileCustom> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MouseRegion(
      onEnter: (event)=>  setState(() => widget.hovercolor = PaletteColors.selectedColor),
      onExit: (event) => setState(() => widget.hovercolor = PaletteColors.white),
      child: Container(
        color: widget.hovercolor,
          child:    GestureDetector(
            onTap: widget.onTap,
            child: ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15 ),
                        width: width*0.07,
                        child: TextCustom(
                          text: widget.date,
                          size: 14.0,
                          color: PaletteColors.grey,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: width*0.08,
                        child: TextCustom(
                          text: widget.assembly,
                          size: 14.0,
                          color: PaletteColors.grey,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15 ),
                        width: width*0.15,
                        child: TextCustom(
                          text: widget.client,
                          size: 14.0,
                          color: PaletteColors.grey,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: width*0.07,
                        child: TextCustom(
                          text: widget.number,
                          size: 14.0,
                          color: PaletteColors.grey,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15 ),
                        width: width*0.1,
                        child: TextCustom(
                          text: widget.winthor,
                          size: 14.0,
                          color: PaletteColors.grey,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15 ),
                        width: width*0.1,
                        child: TextCustom(
                          text: widget.status,
                          size: 14.0,
                          color: PaletteColors.grey,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: width*0.01),
                      widget.showIcons==true?Row(
                        children: [
                          SizedBox(width: width*0.01),
                          Material(
                            color: Colors.transparent,
                            child: Ink(
                              decoration: ShapeDecoration(
                                color:  PaletteColors.primaryColor,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(icon: Icon(
                                Icons.remove_red_eye,
                                color: PaletteColors.white,
                              ),
                                constraints: BoxConstraints(minHeight: 30,
                                    minWidth: 30,
                                    maxHeight: 30,
                                    maxWidth: 30),
                                iconSize: 14.0,
                                padding: EdgeInsets.zero,
                                onPressed: widget.onPressedShow,
                              ),
                            ),
                          ),
                          widget.status != TextConst.producao? SizedBox(width: width*0.01):Container(),
                          widget.status != TextConst.producao?Material(
                            color: Colors.transparent,
                            child: Ink(
                              decoration: ShapeDecoration(
                                color:  PaletteColors.primaryColor,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(icon: Icon(
                                Icons.edit,
                                color: PaletteColors.white,
                              ),
                                constraints: BoxConstraints(minHeight: 30,
                                    minWidth: 30,
                                    maxHeight: 30,
                                    maxWidth: 30),
                                iconSize: 14.0,
                                padding: EdgeInsets.zero,
                                onPressed: widget.onPressedEdit,
                              ),
                            ),
                          ):Container(),
                          SizedBox(width: width*0.01),
                          Material(
                            color: Colors.transparent,
                            child: Ink(
                              decoration: ShapeDecoration(
                                color:  PaletteColors.grey,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(icon: Icon(
                                Icons.control_point_duplicate,
                                color: PaletteColors.white,
                              ),
                                constraints: BoxConstraints(minHeight: 30,
                                    minWidth: 30,
                                    maxHeight: 30,
                                    maxWidth: 30),
                                iconSize: 14.0,
                                padding: EdgeInsets.zero,
                                onPressed: widget.onPressedDuplicated,
                              ),
                            ),
                          ),
                        ],
                      ):SizedBox(height: 0)
                    ],
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}