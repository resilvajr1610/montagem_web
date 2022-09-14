import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Utils/exports.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  List dataProdutos=[];
  List dataClientes=[];
  DateTime? start,end;
  bool loading = false;
  bool sinc = false;
  bool saveFirebase = false;
  bool ok = false;
  bool type = true;
  var time = 0;
  final cors = 'https://cors-anywhere.herokuapp.com/';
  final urlProdutos = 'http://206.84.60.186:8088/api/produto/passwd/P4\$\$';
  final urlClientes = 'http://206.84.60.186:8087/api/cliente/passwd/P4\$\$';
  // final url = 'https://jsonplaceholder.typicode.com/posts';

  apiCorsProduto()async{
    setState((){
      loading=true;
      sinc = true;
      start = DateTime.now();
    });
    var resquest = await http.get(Uri.parse(cors)).then((response) {
      print('r ${response.statusCode}');
      if(response.statusCode == 200){
        print('ok');
        apiDataProdutos();
      }
    });
  }

  apiDataProdutos()async{
    var response = await http.get(Uri.parse('${cors}$urlProdutos'),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": 'true',
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
        }
    ).then((response){
      setState(() {
        dataProdutos = json.decode(response.body);
        loading=false;
        end = DateTime.now();
        time = end!.difference(start!).inSeconds;
      });
      print(dataProdutos.length);
      if(response.statusCode==200){
        sendFirebaseProdutos();
      }
    });
  }

  sendFirebaseProdutos(){
    setState(() {
      saveFirebase=true;
    });
    for(var i =0; i<dataProdutos.length;i++){
      db.collection('produtos').doc(dataProdutos[i]['codprod'].toString()).set({
        'codprod': dataProdutos[i]['codprod'].toString(),
        'numoriginal': dataProdutos[i]['numoriginal'].toString(),
        'informacoestecnicas': dataProdutos[i]['informacoestecnicas'].toString(),
        'marca': dataProdutos[i]['marca'].toString(),
        'estf1': dataProdutos[i]['estf1'].toString(),
        'estf2': dataProdutos[i]['estf2'].toString(),
        'estBloq': dataProdutos[i]['estBloq'].toString(),
        'obs2': dataProdutos[i]['obs2'].toString(),
        'preco': dataProdutos[i]['preco'].toString(),
        'codmola': dataProdutos[i]['codmola'].toString(),
        'qtdmola': dataProdutos[i]['qtdmola'].toString(),
        'pressao': dataProdutos[i]['pressao'].toString(),
        'diametro': dataProdutos[i]['diametro'].toString(),
        'tipoterminal': dataProdutos[i]['tipoterminal'].toString(),
        'codoring': dataProdutos[i]['codoring'].toString(),
      }).then((value) => print('item : $i salvo'));
    }
    setState(() {
      ok=true;
      saveFirebase=false;
    });
  }

  apiCorsClientes()async{
    setState((){
      type = false;
      loading=true;
      sinc = true;
      start = DateTime.now();
    });
    var resquest = await http.get(Uri.parse(cors)).then((response) {
      print('r ${response.statusCode}');
      if(response.statusCode == 200){
        print('ok');
        apiDataClientes();
      }
    });
  }

  apiDataClientes()async{
    var response = await http.get(Uri.parse('${cors}$urlClientes'),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": 'true',
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
        }
    ).then((response){
      setState(() {
        dataClientes = json.decode(response.body);
        loading=false;
        end = DateTime.now();
        time = end!.difference(start!).inSeconds;
      });
      print(dataClientes.length);
      if(response.statusCode==200){
        sendFirebaseClientes();
      }
    });
  }

  sendFirebaseClientes(){
    setState(() {
      saveFirebase=true;
    });
    for(var i =0; i<dataClientes.length;i++){
      db.collection('clientes').doc(dataClientes[i]['codcli'].toString()).set({
        'codcli': dataClientes[i]['codcli'].toString(),
        'cliente': dataClientes[i]['cliente'].toString(),
        'enderent': dataClientes[i]['enderent'].toString(),
        'municient': dataClientes[i]['municient'].toString(),
        'estent': dataClientes[i]['estent'].toString(),
      }).then((value) => print('item : $i salvo'));
    }
    setState(() {
      ok=true;
      saveFirebase=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(70.0),
      child: Container(
        alignment: Alignment.topLeft,
          child: Column(
            children: [
              TextCustom(
                text: 'Olá,\nSelecione uma opção ao lado para prosseguir!',
                maxLines: 2,
                size: 20.0,
                color: PaletteColors.primaryColor,
                fontFamily: 'Nunito',
              ),
              SizedBox(height: 50),
              ButtonCustom(
                  onPressed: ()=>apiCorsProduto(),
                  text: 'Sincronizar dados Produtos',
                  heightCustom: 0.05,
                  widthCustom: 0.1,
              ),
              SizedBox(height: 15),
              ButtonCustom(
                onPressed: ()=>apiCorsClientes(),
                text: 'Sincronizar dados Clientes  ',
                heightCustom: 0.05,
                widthCustom: 0.1,
              ),
              SizedBox(height: 15),
              ButtonCustom(
                onPressed: ()=>launchUrl(Uri.parse(cors)),
                text: 'Habilitar api',
                heightCustom: 0.05,
                widthCustom: 0.1,
              ),
              SizedBox(height: 50),
              Visibility(
                  visible: sinc,
                  child: TextCustom(
                    text: 'itens encontrados: ${type?dataProdutos:dataClientes.length.toString()}',
                    maxLines: 2,
                    size: 20.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                  )
              ),
              SizedBox(height: 20),
              Visibility(
                visible: loading,
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator()
                )
              ),
              SizedBox(height: 10),
              Visibility(
                visible: sinc,
                child: TextCustom(
                  text: '$time segundos',
                  maxLines: 2,
                  size: 20.0,
                  color: PaletteColors.primaryColor,
                  fontFamily: 'Nunito',
                )
              ),
              Visibility(
                visible: saveFirebase,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    TextCustom(
                      text: 'salvando itens, aguarde finalizar',
                      maxLines: 2,
                      size: 20.0,
                      color: PaletteColors.primaryColor,
                      fontFamily: 'Nunito',
                    )
                  ],
                )
              ),
              Visibility(
                  visible: ok,
                  child: TextCustom(
                    text: 'Dados atualizados!',
                    maxLines: 2,
                    size: 20.0,
                    color: PaletteColors.primaryColor,
                    fontFamily: 'Nunito',
                  )
              ),
            ],
          ),

      ),
    );
  }
}
