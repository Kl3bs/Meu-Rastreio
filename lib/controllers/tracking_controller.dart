import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meu_rastreio/models/tracking_model.dart';

const baseUrl = "https://proxyapp.correios.com.br/v1/sro-rastro";

class TrackingController {
  var dio = Dio();

  Future<List<Tracking>> getTranckingInformation(String code) async {
    var response = await dio.get('$baseUrl/$code');
    var json = jsonDecode(response.toString());
    var list = getEventList(json);
    return list;
  }

  List<Tracking> getEventList(Map json) {
    var eventsJsonArray = json["objetos"];
    List<Tracking> eventList = [];

    for (var i = 0; i < eventsJsonArray.length; i++) {
      Tracking item = Tracking(
        situationCode: json["objetos"][0]["eventos"][i]["codigo"],
        date: json["objetos"][0]["eventos"][i]["dtHrCriado"],
        description: json["objetos"][0]["eventos"][i]["descricao"],
        origin: json["objetos"][0]["eventos"][i]["unidade"]["nome"],
        destination: json["objetos"][0]["eventos"][i]["unidadeDestino"]["nome"],
        ufDestination: json["objetos"][0]["eventos"][i]["unidadeDestino"]
            ["endereco"]["uf"],
      );

      eventList.add(item);
    }

    return eventList;
  }
}
