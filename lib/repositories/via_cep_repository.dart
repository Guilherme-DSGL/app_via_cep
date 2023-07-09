import 'dart:convert';

import 'package:app_via_cep/models/cep.dart';
import 'package:http/http.dart' as http;

import '../Exceptions/cep_exceptions.dart';

class ViaCepRepository {
  Future<Cep> getCep(String cepCode) async {
    var url = Uri.parse('https://viacep.com.br/ws/$cepCode/json/');
    var response = await http.get(url);
    Map<String, dynamic> body = jsonDecode(response.body);
    if (!body.containsKey("erro")) {
      return Cep.fromJson(jsonDecode(response.body));
    } else {
      throw CepNotFoundException(message: "Cep nao encontrado");
    }
  }
}
