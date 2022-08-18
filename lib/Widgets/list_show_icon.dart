

import '../Utils/exports.dart';

class ListTileCustom extends StatefulWidget {
  final onTap;
  final date;
  final assembly;
  final client;
  final number;
  final winthor;
  Color hovercolor;
  bool showIcons;


  ListTileCustom({
    required this.hovercolor,
    required this.date,
    required this.assembly,
    required this.client,
    required this.number,
    required this.winthor,
    required this.onTap,
    this.showIcons = false,


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
          child: Column(
            children: [
              GestureDetector(
                onTap: widget.onTap,
                child: ListTile(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15 ),
                            child: TextCustom(
                              text: widget.date,
                              size: 14.0,
                              color: PaletteColors.grey,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: TextCustom(
                              text: widget.assembly,
                              size: 14.0,
                              color: PaletteColors.grey,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: TextCustom(
                              text: widget.client,
                              size: 14.0,
                              color: PaletteColors.grey,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 55 ),
                            child: TextCustom(
                              text: widget.number,
                              size: 14.0,
                              color: PaletteColors.grey,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20 ),
                            child: TextCustom(
                              text: widget.winthor,
                              size: 14.0,
                              color: PaletteColors.grey,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 55),
                          widget.showIcons==true?Row(
                            children: [
                              SizedBox(width: 25),
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
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              SizedBox(width: 25.0),
                              Material(
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
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              SizedBox(width: 25.0),
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
                                    onPressed: () {},
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

            ],

          )
      ),
    );
  }
}