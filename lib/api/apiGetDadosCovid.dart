import 'dart:async';
import 'dart:convert';

import 'package:corona_tracker/model/modelDadosPPais.dart';
import 'package:http/http.dart' as http;

class GetDadosCovid {
  static Future<String> getFlagUrl() async {
    final response = await http
        .get('https://restcountries.eu/rest/v2/name/Dominican Republic');

    var dados = json.decode(response.body);
    if (response.statusCode == 200) {
      return dados[0]['flag'];
    } else {
      throw Exception('Falhou a obter os dados');
    }
  }

  static Future<http.Response> getDadosMundo() {
    return http
        .get('https://covid19-brazil-api.now.sh/api/report/v1/countries');
  }

  static Future<DadosPorPaisData> fetchDadosMundo() async {
    final response = await getDadosMundo();
    DadosPorPaisData dadosPorPais;

    if (response.statusCode == 200) {
      dadosPorPais = DadosPorPaisData.fromJson(json.decode(response.body));
      dadosPorPais.data.sort((a, b) => b.confirmed.compareTo(a.confirmed));
      return dadosPorPais;
    } else {
      throw Exception('Falhou a obter os dados');
    }
  }

  static Future<http.Response> getDadosEstado({String pais}) {
    return http.get('https://covid19-brazil-api.now.sh/api/report/v1');
  }

  static Future<DadosPorEstadoData> fetchDadosPais() async {
    final response = await getDadosEstado();
    DadosPorEstadoData dadosPorEstado;

    if (response.statusCode == 200) {
      dadosPorEstado = DadosPorEstadoData.fromJson(json.decode(response.body));
      dadosPorEstado.data.sort((a, b) => b.cases.compareTo(a.cases));
      return dadosPorEstado;
    } else {
      throw Exception('Falhou a obter os dados');
    }
  }

  static Future<http.Response> getDadosCidades({String uf}) {
    return http.get(
        'https://brasil.io/api/dataset/covid19/caso/data/?format=json&place_type=city&is_last=true&state=' +
            uf);
  }

  static Future<DadosPorCidadeData> fetchDadosEstado({String uf}) async {
    final response = await getDadosCidades(uf: uf);
    DadosPorCidadeData dadosPorEstado;

    if (response.statusCode == 200) {
      dadosPorEstado = DadosPorCidadeData.fromJson(json.decode(response.body));
      dadosPorEstado.data.sort((a, b) => b.confirmed.compareTo(a.confirmed));
      return dadosPorEstado;
    } else {
      throw Exception('Falhou a obter os dados');
    }
  }
}
