import 'package:infrastructure/person/anticorruption/player_traslator.dart';
import 'package:infrastructure/person/dto/person_dto.dart' as person_firebase;
import 'package:domain/person/entities/player.dart' as player_domain;
import 'package:domain/person/entities/coach.dart' as coach_domain;
import 'package:infrastructure/person/dto/coach_dto.dart' as coach_firebase;
import 'package:domain/person/entities/player_data.dart' as playerDataDomain;
import 'package:infrastructure/person/dto/player_data_dto.dart'
    as playerDataFirebase;

class PersonTranslator {
  static player_domain.Player fromDTOtoDomain(
      person_firebase.PersonDTO person) {
    return player_domain.Player(
      cellphone: person.cellphone ?? "",
      dateOfBirth: person.dateOfBirth ?? DateTime.now(),
      email: person.email,
      lastName: person.lastName ?? "",
      name: person.name ?? "",
      photoUrl: person.photoUrl ?? "",
      physicalinfo:
          PlayerTranslator.physicalInfoFromDTOToDomain(person.phsycalInfoDTO),
      player: PersonTranslator.fromFirebaseToDomain(person.playerData),
      uid: person.uid,
    );
  }

  static playerDataDomain.PlayerData fromFirebaseToDomain(
      playerDataFirebase.PlayerDataDTO playerData) {
    playerDataDomain.PlayerData playerDto = playerDataDomain.PlayerData(
        dorsal: playerData.dorsal,
        position: playerData.position,
        secondaryPosition: playerData.secondaryPosition);
    return playerDto;
  }
}

class CoachTranslator {
  static coach_domain.Coach fromDTOtoDomain(coach_firebase.Coach person) {
    return coach_domain.Coach(
      cellphone: person.cellphone ?? "",
      dateOfBirth: person.dateOfBirth ?? DateTime.now(),
      email: person.email,
      lastName: person.lastName ?? "",
      name: person.name ?? "",
      photoUrl: person.photoUrl ?? "",
      uid: "",
    );
  }
}
