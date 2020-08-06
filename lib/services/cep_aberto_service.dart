import 'dart:io';

import 'package:dio/dio.dart';
import 'package:saudavel_life_v2/models/cep_aberto_address.dart';

const token = "12aac066597fe4b6bceb9e5d26b24c45";

class CepAbertoService {
  Future<CepAbertoAddress> getAddressFromCep(String cep) async {
    final cleancep = cep.replaceAll(".", "").replaceAll("-", "");
    final endpoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleancep";
    final Dio dio = Dio();
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';
    try {
      final response = await dio.get<Map<String, dynamic>>(endpoint);

      if (response.data.isEmpty) {
        return Future.error("CEP Inválido");
      }
      final CepAbertoAddress address = CepAbertoAddress.fromMap(response.data);
      return address;
      // ignore: unused_catch_clause
    } on DioError catch (e) {
      return Future.error("Erro ao buscar CEP");
    }
  }
}
