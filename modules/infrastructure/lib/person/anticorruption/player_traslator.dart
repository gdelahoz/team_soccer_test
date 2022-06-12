import 'package:infrastructure/person/dto/player_data_dto.dart'
    as playerDataFirebase;
import 'package:infrastructure/person/dto/physcal_info_dto.dart'
    as physcalInfoFirebase;
import 'package:domain/person/entities/player_data.dart' as playerDataDomain;
import 'package:domain/person/entities/physical_info.dart'
    as physicalInfoDomain;

class PlayerTranslator {
  static playerDataDomain.PlayerData fromDTOToDomain(
      playerDataFirebase.PlayerDataDTO playerData) {
    playerDataDomain.PlayerData playerDto = playerDataDomain.PlayerData(
        dorsal: playerData.dorsal,
        position: playerData.position,
        secondaryPosition: playerData.secondaryPosition);
    return playerDto;
  }

  static physicalInfoDomain.PhysicalInfo physicalIngofromDTOToDomain(
      physcalInfoFirebase.PhsycalInfoDTO physicalInfo) {
    physicalInfoDomain.PhysicalInfo playerDto = physicalInfoDomain.PhysicalInfo(
        heigth: physicalInfo.heigth, weight: physicalInfo.weight);
    return playerDto;
  }

  static physicalInfoDomain.PhysicalInfo physicalInfoFromDTOToDomain(
      physcalInfoFirebase.PhsycalInfoDTO physicalInfo) {
    physicalInfoDomain.PhysicalInfo playerDto = physicalInfoDomain.PhysicalInfo(
        heigth: physicalInfo.heigth, weight: physicalInfo.weight);
    return playerDto;
  }
}
