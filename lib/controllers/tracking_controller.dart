import 'package:dio/dio.dart';

const baseUrl = "https://proxyapp.correios.com.br/v1/sro-rastro";

class TrackingController {
  var dio = Dio();

  Future getTranckingInformation(String code) async {
    var response = await dio.get('$baseUrl/$code');

    return response;
  }
}
