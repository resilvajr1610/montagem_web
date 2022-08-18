

import '../Utils/exports.dart';

class ListTileCustom extends StatelessWidget {
  final onTap;
  bool showIcons;
  final text;


  ListTileCustom({
    required this.text,
    required this.onTap,
    this.showIcons = false,


  });



  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: onTap,
              child: ListTile(
                title: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15 ),
                          child: TextCustom(
                            text: text,
                            size: 14.0,
                            color: PaletteColors.grey,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
            showIcons==true?Padding(
              padding: const EdgeInsets.all(10.0),

              child: Row(
                children: [
                  SizedBox(width: 10),
                  Ink(
                    decoration: ShapeDecoration(
                      color:  PaletteColors.primaryColor,
                      shape: CircleBorder(),


                    ),
                    child: IconButton(icon: Icon(
                      Icons.remove_red_eye,
                      color: PaletteColors.white,
                    ),
                      constraints: BoxConstraints(minHeight: 46,
                          minWidth: 46,
                          maxHeight: 46,
                          maxWidth: 46),
                      iconSize: 32.0,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 10),
                  Ink(
                    decoration: ShapeDecoration(
                      color:  PaletteColors.primaryColor,
                      shape: CircleBorder(),


                    ),
                    child: IconButton(icon: Icon(
                      Icons.edit,
                      color: PaletteColors.white,
                    ),
                      constraints: BoxConstraints(minHeight: 46,
                          minWidth: 46,
                          maxHeight: 46,
                          maxWidth: 46),
                      iconSize: 32.0,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 10),
                  Ink(
                    decoration: ShapeDecoration(
                      color:  PaletteColors.grey,
                      shape: CircleBorder(),


                    ),
                    child: IconButton(icon: Icon(
                      Icons.control_point_duplicate,
                      color: PaletteColors.white,
                    ),
                      constraints: BoxConstraints(minHeight: 46,
                          minWidth: 46,
                          maxHeight: 46,
                          maxWidth: 46),
                      iconSize: 32.0,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                    ),
                  ),



                ],

              ),



            ):SizedBox(height: 0)
          ],

        )
    );
  }
}