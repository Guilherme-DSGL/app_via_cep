import 'package:app_via_cep/Exceptions/cep_exceptions.dart';
import 'package:app_via_cep/models/cep.dart';
import 'package:app_via_cep/repositories/cep_back4app_repository.dart';
import 'package:flutter/material.dart';

import '../repositories/cep_repository.dart';

class HomeController extends ChangeNotifier {
  final ICepRepository _cepRepository = CepBack4AppRepository();
  List<Cep> ceps = [];

  void addCep(Cep cep) async {
    final index =
        ceps.indexWhere((element) => element.objectId == cep.objectId);
    if (index >= 0) {
      ceps[index] = ceps[index].copyWith(
        cep: cep.cep,
        logradouro: cep.logradouro,
        complemento: cep.complemento,
        bairro: cep.bairro,
        localidade: cep.localidade,
      );
    } else {
      ceps.add(cep);
    }
    notifyListeners();
  }

  void getHistory() async {
    ceps.addAll(await _cepRepository.get());
    notifyListeners();
  }

  Future<bool> deleteCep(String objectId) async {
    try {
      await _cepRepository.delete(objectId);
      return true;
    } on CepDeleteException {
      return false;
    }
  }

  removeCep(String objectId) {
    ceps.removeWhere((element) => element.objectId == objectId);
  }
}
