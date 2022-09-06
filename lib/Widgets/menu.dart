

import 'package:firebase_auth/firebase_auth.dart';

import '../Utils/exports.dart';

class Menu extends StatelessWidget {
  final index;

  Menu({required this.index});

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Flexible(
        flex: 1,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20)),
                border: Border.all(color: PaletteColors.backGrey),
                color: PaletteColors.primaryColor
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height *0.1
                ),
                SizedBox(
                  height: height * 0.2,
                  width: width*0.3,
                  child: TextCustom(
                    text: 'Controle de \nMontagem' ,
                    color: PaletteColors.white,
                    size: 24.0,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                    maxLines: 3, fontFamily: 'Secular One',


                  ),
                ),
                TitleMenu(
                  index: 0,
                  text: 'Home',
                  icon: Icons.home,

                  select: this.index==0?true:false,

                ),

                TitleMenu(
                  index: 1,
                  text: 'Montagem',
                  icon: Icons.build_circle_outlined,
                  select: this.index==1?true:false,
                ),
                TitleMenu(
                  index: 2,
                  text: 'Historico',
                  icon: Icons.history,
                  select:  this.index==2?true:false,
                ),
                TitleMenu(
                  index: 3,
                  text: 'Pendentes',
                  icon: Icons.pending_actions_outlined,
                  select:  this.index==3?true:false,
                ),

                Spacer(),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(24.0),
                  child: IconButton(
                      icon: Icon(Icons.logout,color: Colors.white,size: 30),
                    onPressed: ()=>FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacementNamed(context, '/login'))
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}