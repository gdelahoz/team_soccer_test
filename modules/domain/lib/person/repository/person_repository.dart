import 'package:domain/person/entities/person.dart';
import 'package:domain/person/entities/player.dart';

abstract class PersonRepository<T> {
  Future<Player> loginFirebase(String email, String password);
  Future<T> registerUserFirebase(String email, String password);
  void logoutFirebase();
}
