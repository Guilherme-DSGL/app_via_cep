import 'package:app_via_cep/models/cep.dart';

abstract interface class ICepRepository {
  Future<List<Cep>> get();
  void save(Cep cep);
  Future<void> delete(String objectId);
  Future<Cep> edit(Cep cep);
}
