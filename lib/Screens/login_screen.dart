import '../Utils/exports.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  bool visiblePassword = false;


  @override
  Widget build(BuildContext context) {


    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: PaletteColors.primaryColor,
      body: Center(
        child: Column(

          children: [
            SizedBox(height: 120),

            Container(
              width: 400,



              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight:Radius.circular(20.0) ,topLeft: Radius.circular(20.0) ),
                color: PaletteColors.inputGrey,


              ),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height*0.10),
                  SizedBox(
                    height: 70,
                    width: width*0.15,
                    child: TextCustom(
                      text: 'Controle de \nMontagem' ,
                      color: PaletteColors.primaryColor,
                      size: 24.0,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      maxLines: 2, fontFamily: 'Secular One',


                    ),
                  ),
                  SizedBox(height:  height * 0.06),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 280,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 11.0
                      ),
                      child: TextCustom(
                          text: "E-Mail",
                          color: PaletteColors.primaryColor,
                          size: 14.0, fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  InputRegister(
                      controller: _controllerEmail,
                      hint: 'E-mail',
                      fonts: 14.0,
                      keyboardType: TextInputType.text,
                      width: width*0.2,
                      sizeIcon: 0.01,
                      icons: Icons.height,
                      colorBorder: PaletteColors.white,
                      background: PaletteColors.white,
                  ),
                  SizedBox(height: height*0.02),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 280,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 11.0
                      ),
                      child: TextCustom(
                        text: "Senha",
                        color: PaletteColors.primaryColor,
                        size: 14.0, fontFamily:'Nunito',
                      ),
                    ),
                  ),
                  InputPassword(
                      controller: _controllerPassword,
                      hint: '********',
                      fonts: 14.0,
                      keyboardType: TextInputType.visiblePassword,
                      obscure: visiblePassword,
                      width: width*0.2,
                      colorIcon: PaletteColors.primaryColor,
                      colorBorder: PaletteColors.white,
                      background: PaletteColors.white,
                      iconbackground: PaletteColors.white,
                      icons: Icons.height,
                      showPassword: visiblePassword,
                      onPressed: (){
                        setState(() {
                          if(visiblePassword==false){
                            visiblePassword=true;
                          }else{
                            visiblePassword=false;
                          }
                        });
                      },
                  ),
                  SizedBox(height: height*0.05),
                  Padding(
                       padding: const EdgeInsets.all(8.0),
                    child: ButtonCustom(
                      widthCustom: 0.20,
                      heightCustom: 0.07,
                      text: "Entrar",
                      size: 14.0,
                      colorText: PaletteColors.white,
                      colorButton: PaletteColors.primaryColor,
                      colorBorder: PaletteColors.primaryColor,
                      onPressed: ()=> Navigator.popAndPushNamed(context, '/home'),

                    ),
                  ),
                  SizedBox(height: height*0.09),

                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
