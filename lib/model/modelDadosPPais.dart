import 'package:corona_tracker/api/apiGetDadosCovid.dart';

class DadosPorPaisData {
  List<dynamic> data;

  DadosPorPaisData({this.data});

  factory DadosPorPaisData.fromJson(Map<String, dynamic> json) {
    var list = json['data'];
    List<dynamic> dadosList =
        list.map((i) => DadosPorPais.fromJson(i)).toList();

    return DadosPorPaisData(
      data: dadosList,
    );
  }
}

class DadosPorPais {
  String name;
  int cases;
  int confirmed;
  int deaths;
  int recovered;
  String newDeaths;
  String newCases;
  String criticalCases;
  String activeCases;
  String flagUrl;

  DadosPorPais({
    this.name,
    this.cases,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.newDeaths,
    this.newCases,
    this.criticalCases,
    this.activeCases,
  });

  factory DadosPorPais.fromJson(Map<String, dynamic> json) {
    return DadosPorPais(
      name: json['country'],
      cases: json['cases'],
      confirmed: json['confirmed'],
      deaths: json['deaths'],
      recovered: json['recovered'],
    );
  }
}

class DadosPorEstadoData {
  List<dynamic> data;

  DadosPorEstadoData({this.data});

  factory DadosPorEstadoData.fromJson(Map<String, dynamic> json) {
    var list = json['data'];
    List<dynamic> dadosList =
        list.map((i) => DadosPorEstado.fromJson(i)).toList();

    return DadosPorEstadoData(
      data: dadosList,
    );
  }
}

class DadosPorEstado {
  String uf;
  String state;
  int cases;
  int deaths;
  int suspects;
  int refuses;

  DadosPorEstado({
    this.uf,
    this.state,
    this.cases,
    this.deaths,
    this.suspects,
    this.refuses,
  });

  factory DadosPorEstado.fromJson(Map<String, dynamic> json) {
    return DadosPorEstado(
      uf: json['uf'],
      state: json['state'],
      cases: json['cases'],
      deaths: json['deaths'],
      suspects: json['suspects'],
      refuses: json['refuses'],
    );
  }
}

class DadosPorCidadeData {
  List<dynamic> data;

  DadosPorCidadeData({this.data});

  factory DadosPorCidadeData.fromJson(Map<String, dynamic> json) {
    var list = json['results'];
    List<dynamic> dadosList =
        list.map((i) => DadosPorCidade.fromJson(i)).toList();

    return DadosPorCidadeData(
      data: dadosList,
    );
  }
}

class DadosPorCidade {
  String city;
  int confirmed;
  int deaths;
  DadosPorCidade({
    this.city,
    this.confirmed,
    this.deaths,
  });

  factory DadosPorCidade.fromJson(Map<String, dynamic> json) {
    return DadosPorCidade(
      city: json['city'],
      confirmed: json['confirmed'],
      deaths: json['deaths'],
    );
  }
}
