import 'package:domain/person/entities/person.dart';
import 'package:domain/person/entities/player.dart';

abstract class PersonLocalRespository {
  Future<bool> savePerson(Player person);
  Future<Person?> getPerson(String email);
  Future<void> updatePersona(Person person);
}
