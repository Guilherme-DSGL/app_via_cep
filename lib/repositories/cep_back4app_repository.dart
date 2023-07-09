import 'dart:convert';

import 'package:app_via_cep/Exceptions/cep_exceptions.dart';

import '../models/cep.dart';
import 'cep_repository.dart';
import 'package:http/http.dart' as http;

class CepBack4AppRepository implements ICepRepository {
  @override
  Future<void> save(Cep cep) async {
    var url = Uri.parse("https://parseapi.back4app.com/classes/cep");
    var body = jsonEncode(cep.toJson());
    final result = await http.post(url,
        headers: {
          "X-Parse-Application-Id": "AEyPbr8eaS0mrhAIKW9ICLNzQZoY3dPWJrQJNsCk",
          "X-Parse-REST-API-Key": "HndSMkxBc0Jh22Slg74CZ7nfMBsPRsfUl90CBDKT",
          "Content-Type": "application/json",
        },
        body: body);
    if (result.statusCode != 201) {
      throw CepSaveException(message: "Nao foi possivel salvar");
    }
  }

  @override
  Future<List<Cep>> get() async {
    var url = Uri.parse("https://parseapi.back4app.com/classes/cep");
    final result = await http.get(
      url,
      headers: {
        "X-Parse-Application-Id": "AEyPbr8eaS0mrhAIKW9ICLNzQZoY3dPWJrQJNsCk",
        "X-Parse-REST-API-Key": "HndSMkxBc0Jh22Slg74CZ7nfMBsPRsfUl90CBDKT",
        "Content-Type": "application/json",
      },
    );
    final results = jsonDecode(result.body)["results"];
    if (results == null) {
      throw CepExitsException(message: "Nao foi possivel pegar");
    }
    final List<dynamic> data = results;
    return Cep.fromListJson(data);
  }

  Future<void> exits(String cepCode) async {
    var url = Uri.parse(
        'https://parseapi.back4app.com/classes/cep?where={"cep":"$cepCode"}');
    final result = await http.get(
      url,
      headers: {
        "X-Parse-Application-Id": "AEyPbr8eaS0mrhAIKW9ICLNzQZoY3dPWJrQJNsCk",
        "X-Parse-REST-API-Key": "HndSMkxBc0Jh22Slg74CZ7nfMBsPRsfUl90CBDKT",
      },
    );
    final List<dynamic> data =
        jsonDecode(result.body)["results"] ?? List.empty();
    if (data.isNotEmpty) {
      throw CepExitsException(message: "Cep ja existe");
    }
  }

  @override
  Future<void> delete(String objectId) async {
    var url = Uri.parse('https://parseapi.back4app.com/classes/cep/$objectId');
    final result = await http.delete(
      url,
      headers: {
        "X-Parse-Application-Id": "AEyPbr8eaS0mrhAIKW9ICLNzQZoY3dPWJrQJNsCk",
        "X-Parse-REST-API-Key": "HndSMkxBc0Jh22Slg74CZ7nfMBsPRsfUl90CBDKT",
      },
    );
    print(result.body);
    if (result.statusCode != 200) {
      throw CepDeleteException(message: "Nao foi posivel deletar");
    }
  }

  @override
  Future<Cep> edit(Cep cep) async {
    var url =
        Uri.parse('https://parseapi.back4app.com/classes/cep/${cep.objectId}');
    final result = await http.put(url,
        headers: {
          "X-Parse-Application-Id": "AEyPbr8eaS0mrhAIKW9ICLNzQZoY3dPWJrQJNsCk",
          "X-Parse-REST-API-Key": "HndSMkxBc0Jh22Slg74CZ7nfMBsPRsfUl90CBDKT",
        },
        body: cep.toJson());
    print(result.body);
    if (result.statusCode != 200) {
      throw CepEditException(message: "nao foi possivel editar");
    }
    return cep;
  }
}
