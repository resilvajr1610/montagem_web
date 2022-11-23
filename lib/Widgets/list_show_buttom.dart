

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Utils/exports.dart';
import '../Utils/text_const.dart';

class ListTileButtom extends StatefulWidget {
  final onTap;
  bool showButtom;
  int makerOrder;
  final whinthor;
  final date;
  final client;
  final priority;
  final status;
  Color hovercolor;
  final args;

  ListTileButtom({
    required this.makerOrder,
    required this.whinthor,
    required this.date,
    required this.client,
    required this.priority,
    required this.status,
    required this.hovercolor,
    required this.onTap,
    this.showButtom = false,
    required this.args
  });

  @override
  State<ListTileButtom> createState() => _ListTileButtomState();
}

class _ListTileButtomState extends State<ListTileButtom> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  int makerOrder = 0;

  makerOrderRec()async{
    DocumentSnapshot snapshot = await db.collection("order").doc('order').get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    setState((){
      makerOrder = data?["makerOrder"]??0;

      print(makerOrder);
      if(makerOrder!=0){
        makerOrder = makerOrder+1;
      }
    });

    if(widget.makerOrder!=0){
      FirebaseFirestore.instance.collection('assembly').doc(widget.args).update({
        'status': TextConst.producao,
      }).then((value) => Navigator.popAndPushNamed(context, '/prod',arguments: widget.args));
    }else{
      FirebaseFirestore.instance.collection('assembly').doc(widget.args).update({
        'status': TextConst.producao,
        'makerOrder' : makerOrder
      }).then((value){
        FirebaseFirestore.instance.collection('order').doc('order').update({
          'makerOrder':makerOrder
        });
      }).then((value) => Navigator.popAndPushNamed(context, '/prod',arguments: widget.args));
    }
  }

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
                        SizedBox(width: 15),
                        Container(
                          width: width * 0.12,
                          child: TextCustom(
                            text: widget.makerOrder!=0?widget.makerOrder.toString():makerOrder.toString(),
                            size: 14.0,
                            color: PaletteColors.grey,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                            
                          ),
                        ),
                        Container(
                          width: width * 0.10,
                          child: TextCustom(
                            text:
                            widget.whinthor,
                            maxLines: 4,
                            size: 14.0,
                            color: PaletteColors.grey,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          width: width * 0.12,
                          child: TextCustom(
                            text: widget.date,
                            size: 14.0,
                            color: PaletteColors.grey,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                            
                          ),
                        ),
                        Container(
                          width: width * 0.22,
                          child: TextCustom(
                            text: widget.client,
                            size: 14.0,
                            color: PaletteColors.grey,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                            
                          ),
                        ),
                        Container(
                          width: width* 0.09,
                          child: TextCustom(
                            text: widget.priority,
                            size: 14.0,
                            color: PaletteColors.grey,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                            
                          ),
                        ),
                        Container(
                          width: width * 0.1,
                          child: TextCustom(
                            text: widget.status,
                            size: 14.0,
                            color: PaletteColors.grey,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                            
                          ),
                        ),
                        
                      ],
                    ),
                    widget.showButtom==true?Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            color:  Colors.transparent,
                            child: ButtonCustom(
                              widthCustom: 0.1,
                              heightCustom: 0.07,
                              text: "Iniciar Produção",
                              size: 14.0,
                              colorText: PaletteColors.white,
                              colorButton: PaletteColors.primaryColor,
                              colorBorder: PaletteColors.primaryColor,
                              onPressed: ()=> makerOrderRec(),
                              font: 'Nunito',
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                      ],
                    ):SizedBox(height: 0.1),
                  ],
                ),
              ),
            ),
          ],
        ),

      ),
    );

  }
  onEnter(_) {
    setState(() => widget.hovercolor = PaletteColors.selectedColor
    );
  }
  onExit(_) {
    setState(() => widget.hovercolor = PaletteColors.white
    );
  }
}