import 'package:corona_tracker/api/apiGetDadosCovid.dart';
import 'package:corona_tracker/model/modelDadosPPais.dart';
import 'package:corona_tracker/pages/pageDetail.dart';
import 'package:corona_tracker/pages/pageNavDrawer.dart';
import 'package:corona_tracker/constants.dart';
import 'package:corona_tracker/pages/widgetHeader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CasosPage extends StatefulWidget {
  CasosPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CasosPageState createState() => _CasosPageState();
}

class _CasosPageState extends State<CasosPage> {
  DadosPorPaisData dadosPorPais = new DadosPorPaisData();
  final formatter = new NumberFormat("#,###", "pt_BR");

  @override
  void initState() {
    GetDadosCovid.fetchDadosMundo().then((value) async {
      setState(() {
        dadosPorPais = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //drawer: NavDrawer(),
        appBar: AppBar(
          title: Text(
            "Casos COVID-19",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        //  Expanded(
        //   child: body(),
        // )
        body: body());
  }

  Widget body() {
    if (dadosPorPais.data != null) {
      return ListView.builder(
        itemCount: dadosPorPais.data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PageDetail(
                            index: index,
                            paisData: dadosPorPais.data[index],
                          )),
                );
              },
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Icon(Icons.navigate_next),
                ],
              ),
              title: Text(dadosPorPais.data[index].name),
              subtitle: Text("Casos: " +
                  formatter.format(dadosPorPais.data[index].confirmed)),
            ),
          );
        },
      );
    }
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          Text(
            "Carregando...",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ));
  }

  Future<String> getFlagUrl() async {
    return GetDadosCovid.getFlagUrl();
  }
}
