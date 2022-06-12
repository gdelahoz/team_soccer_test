import 'package:domain/person/entities/person.dart';
import 'package:domain/person/repository/person_local_repository.dart';
import 'package:domain/person/repository/person_repository.dart';

class PersonServices {
  PersonServices(
      {required PersonLocalRespository localRepo,
      required PersonRepository remoteRepo})
      : _locaRepo = localRepo,
        _remoteRepo = remoteRepo,
        super();

  final PersonRepository _remoteRepo;
  final PersonLocalRespository _locaRepo;

  Future<Person> login(String email, String password) async {
    final localPerson = await _locaRepo.getPerson(email);
    if (localPerson == null) {
      final user = await _remoteRepo.loginFirebase(email, password);
      await _locaRepo.savePerson(user);
    }
    return (await _locaRepo.getPerson(email))!;
  }

  Future<Person> getUser(String email) async {
    return (await _locaRepo.getPerson(email))!;
  }
}
