import 'dart:convert';

import 'package:corona_tracker/api/apiGetDadosCovid.dart';
import 'package:corona_tracker/model/modelDadosPPais.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageDetailUF extends StatefulWidget {
  final DadosPorEstado estadoData;

  PageDetailUF({this.estadoData});
  @override
  _PageDetailUFState createState() => _PageDetailUFState();
}

class _PageDetailUFState extends State<PageDetailUF> {
  DadosPorCidadeData dadosPorEstado = new DadosPorCidadeData();

  @override
  void initState() {
    GetDadosCovid.fetchDadosEstado(uf: widget.estadoData.uf).then((value) {
      dadosPorEstado = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.network(
                  "https://devarthurribeiro.github.io/covid19-brazil-api/static/flags/" +
                      widget.estadoData.uf +
                      ".png"),
              SizedBox(
                width: 25,
              ),
              Text(
                widget.estadoData.state,
                style: TextStyle(color: Colors.black),
              ),
            ],
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

    /*list.add(Container(
      padding: EdgeInsets.all(8),
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(),
            color: Color.fromRGBO(152, 181, 235, 1),
            borderRadius: BorderRadius.all(
                Radius.circular(5.0) //                 <--- border radius here
                ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(Icons.info),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                    "Devido ao tempo de atualização dos dados os numeros de casos por cidade pode variar com o total do estado."),
              )
            ],
          )),
    ));*/

    list.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        cardInfo(
            tipo: "Casos",
            valor: widget.estadoData.cases,
            icon: Icons.all_inclusive),
        cardInfo(
            tipo: "Mortes",
            valor: widget.estadoData.deaths,
            icon: Icons.airline_seat_flat_angled),
      ],
    ));

    if (dadosPorEstado.data != null) {
      for (var i = 0; i < dadosPorEstado.data.length; i++) {
        list.add(GestureDetector(
          child: ListTile(
            title:
                Text(utf8.decode(dadosPorEstado.data[i].city.runes.toList())),
            subtitle: Text("Casos: " +
                formatter.format(dadosPorEstado.data[i].confirmed) +
                " - Mortes: " +
                formatter.format(dadosPorEstado.data[i].deaths)),
          ),
        ));
      }
    }
    return list;
  }

  Widget body() {
    if (dadosPorEstado.data != null) {
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
