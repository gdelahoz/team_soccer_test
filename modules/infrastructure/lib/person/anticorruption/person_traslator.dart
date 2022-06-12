import 'dart:convert';

import 'package:domain/person/entities/person.dart' as personDomain;
import 'package:domain/person/entities/player.dart' as personPlayer;
import 'package:infrastructure/database/model.dart' as personDB;
import 'package:infrastructure/person/anticorruption/player_traslator.dart';
import 'package:infrastructure/person/dto/person_dto.dart' as personFirebase;
import 'package:infrastructure/person/dto/player_data_dto.dart'
    as playerDataFirebase;
import 'package:domain/person/entities/player_data.dart' as playerDataDomain;
import 'package:domain/person/entities/physical_info.dart'
    as physicalInfoDomain;

class PersonTranslator {
  static personDB.Person fromDomainToBD(personPlayer.Player person) {
    personDB.Person personDTO = personDB.Person(
        uid: person.getUid(),
        name: person.getName(),
        lastName: person.getLastName(),
        email: person.getEmail(),
        physicalinfo:
            '{"heigth": ${person.getPhysicalInfo().getHeigth().toString()}, "weight": ${person.getPhysicalInfo().getWeight().toString()} }',
        dataPlayer:
            '{"dorsal": ${person.getPlayerData().getDorsal()}, "position": "${person.getPlayerData().getPosition().toString()}", "secondaryPosition": "${person.getPlayerData().getSecondaryPosition().toString()}" }',
        cellphone: person.getCellPhone(),
        photoUrl: person.getPhotoUrl(),
        dateOfBirth: person.getDateOfBirth());
    return personDTO;
  }

  static personDomain.Person fromBDToDomain(personDB.Person person) {
    personDomain.Person personDTO = personPlayer.Player(
        name: person.name!,
        lastName: person.lastName!,
        player: playerDataDomain.PlayerData.fromJson(
            jsonDecode(person.dataPlayer!)),
        physicalinfo: physicalInfoDomain.PhysicalInfo.fromJson(
            jsonDecode(person.physicalinfo!)),
        uid: person.uid!,
        photoUrl: person.photoUrl!,
        dateOfBirth: person.dateOfBirth!,
        email: person.email!,
        cellphone: person.cellphone!);
    return personDTO;
  }

  static personDomain.Person fromDTOToDomain(personFirebase.PersonDTO person) {
    personDomain.Person personDTO = personPlayer.Player(
        name: person.name!,
        lastName: person.lastName!,
        photoUrl: person.photoUrl!,
        player: PlayerTranslator.fromDTOToDomain(person.playerData),
        physicalinfo:
            PlayerTranslator.physicalIngofromDTOToDomain(person.phsycalInfoDTO),
        cellphone: person.cellphone!,
        uid: person.uid,
        dateOfBirth: person.dateOfBirth!,
        email: person.email);
    return personDTO;
  }
}
