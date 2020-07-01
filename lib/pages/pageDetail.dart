import 'package:corona_tracker/api/apiGetDadosCovid.dart';
import 'package:corona_tracker/model/modelDadosPPais.dart';
import 'package:corona_tracker/pages/pageDetailUF.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageDetail extends StatefulWidget {
  final DadosPorPais paisData;
  final int index;

  PageDetail({this.index, this.paisData});
  @override
  _PageDetailState createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  DadosPorEstadoData dadosPorEstado = new DadosPorEstadoData();

  @override
  void initState() {
    if (widget.paisData.name == "Brazil") {
      GetDadosCovid.fetchDadosPais().then((value) {
        dadosPorEstado = value;
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.paisData.name,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            Expanded(
              child: body(),
            ),
          ],
        ));
  }

  List<Widget> listBody() {
    final formatter = new NumberFormat("#,###", "pt_BR");
    var list = new List<Widget>();
    list.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        cardInfo(
            tipo: "Casos",
            valor: widget.paisData.confirmed,
            icon: Icons.all_inclusive),
        cardInfo(
            tipo: "Mortes",
            valor: widget.paisData.deaths,
            icon: Icons.airline_seat_flat_angled),
      ],
    ));
    list.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        cardInfo(
            tipo: "Ativos", valor: widget.paisData.cases, icon: Icons.check),
        cardInfo(
            tipo: "Curados",
            valor: widget.paisData.recovered,
            icon: Icons.local_hospital),
      ],
    ));

    if (dadosPorEstado.data != null) {
      for (var i = 0; i < dadosPorEstado.data.length; i++) {
        list.add(GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PageDetailUF(
                        estadoData: dadosPorEstado.data[i],
                      )),
            );
          },
          child: ListTile(
            leading: Image.network(
                "https://devarthurribeiro.github.io/covid19-brazil-api/static/flags/" +
                    dadosPorEstado.data[i].uf +
                    ".png"),
            title: Text(dadosPorEstado.data[i].state),
            trailing: Wrap(
              spacing: 12, // space between two icons
              children: <Widget>[
                Icon(Icons.navigate_next),
              ],
            ),
            subtitle: Text(
                "Casos: " + formatter.format(dadosPorEstado.data[i].cases)),
          ),
        ));
      }
    }
    return list;
  }

  Widget body() {
    if (dadosPorEstado.data != null ||
        (dadosPorEstado.data == null && widget.paisData.name != "Brazil")) {
      return ListView(children: listBody());
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

  Widget cardInfo({String tipo, int valor, IconData icon}) {
    final formatter = new NumberFormat("#,###", "pt_BR");
    return Card(
      child: new Container(
          width: MediaQuery.of(context).size.width / 2.1,
          height: 80,
          //padding: new EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: 45,
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Text(tipo),
                  new Text(formatter.format(valor))
                ],
              ),
            ],
          )),
    );
  }
}
