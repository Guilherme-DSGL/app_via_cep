import 'package:app_via_cep/Exceptions/cep_exceptions.dart';
import 'package:app_via_cep/repositories/cep_back4app_repository.dart';
import 'package:app_via_cep/repositories/via_cep_repository.dart';

import '../models/cep.dart';

class DialogController {
  Cep cep = Cep();
  final CepBack4AppRepository _cepBack4AppRepository = CepBack4AppRepository();
  bool isLoading = false;

  final ViaCepRepository _viaCepRepository = ViaCepRepository();

  Future<String?> sendCep({required String cepCode, String? objectId}) async {
    isLoading = true;
    try {
      cep = await _viaCepRepository.getCep(cepCode);
      await _cepBack4AppRepository.exits(cepCode);
      if (objectId != null) {
        cep = cep.copyWith(objectId: objectId);
        await _cepBack4AppRepository.edit(cep);
      } else {
        await _cepBack4AppRepository.save(cep);
      }
      isLoading = false;
      return null;
    } on ExeptionMessage catch (e) {
      isLoading = false;
      return e.message;
    }
  }
}
