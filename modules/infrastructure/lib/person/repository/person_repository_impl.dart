import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:infrastructure/person/anticorruption/person_traslator.dart';
import 'package:infrastructure/person/dto/person_dto.dart';

class PersonFirebaseRepositoryImpl implements PersonRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<Player> loginFirebase(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    var person;
    await _db
        .collection('Users')
        .where(authResult.user!.uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              PersonDTO personDTO = PersonDTO.fromFirestore(element.data());
              person = PersonTranslator.fromDTOToDomain(personDTO);
            }));
    return person;
  }

  @override
  void logoutFirebase() async {
    await _auth.signOut().then((value) => {print("Sesion cerrada")});
  }

  @override
  Future registerUserFirebase(String email, String password) async {}
}
