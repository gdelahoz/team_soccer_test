import 'package:domain/person/entities/person.dart';
import 'package:domain/person/entities/player.dart';
import 'package:domain/person/repository/person_local_repository.dart';
import 'package:infrastructure/database/model.dart' as personDB;
import 'package:infrastructure/person/anticorruption/person_traslator.dart';

class PersonLocalRepositoryImpl implements PersonLocalRespository {
  @override
  Future<Person?> getPerson(String email) async {
    final data =
        await personDB.Person().select().email.equals(email).toSingle();
    if (data != null) {
      var person = PersonTranslator.fromBDToDomain(data);
      return person;
    }
    return null;
  }

  @override
  Future<bool> savePerson(Player person) async {
    var dbModel = PersonTranslator.fromDomainToBD(person);
    (await personDB.Person().getById(dbModel.uid))?.delete(true);
    return (await dbModel.save()).success;
  }

  @override
  Future<void> updatePersona(Person person) {
    // TODO: implement updatePersona
    throw UnimplementedError();
  }
}
