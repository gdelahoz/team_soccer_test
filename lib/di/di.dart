import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:infrastructure/infrastructure.dart';

void diInitializer() {
  if (!GetIt.I.isRegistered<EventFirebaseRepositoryImpl>()) {
    GetIt.I.registerSingleton<EventFirebaseRepositoryImpl>(
        EventFirebaseRepositoryImpl());
  }

  if (!GetIt.I.isRegistered<PersonFirebaseRepositoryImpl>()) {
    GetIt.I.registerSingleton<PersonFirebaseRepositoryImpl>(
        PersonFirebaseRepositoryImpl());
  }

  if (!GetIt.I.isRegistered<PersonLocalRepositoryImpl>()) {
    GetIt.I.registerSingleton<PersonLocalRepositoryImpl>(
        PersonLocalRepositoryImpl());
  }
  //Domain Modules
  if (!GetIt.I.isRegistered<PersonServices>()) {
    GetIt.I.registerSingleton<PersonServices>(PersonServices(
        localRepo: GetIt.I.get<PersonLocalRepositoryImpl>(),
        remoteRepo: GetIt.I.get<PersonFirebaseRepositoryImpl>()));
  }

  if (!GetIt.I.isRegistered<EventServices>()) {
    GetIt.I.registerSingleton<EventServices>(
        EventServices(remoteRepo: GetIt.I.get<EventFirebaseRepositoryImpl>()));
  }

  if (!GetIt.I.isRegistered<AdvertisementFirebaseRepositoryImpl>()) {
    GetIt.I.registerSingleton<AdvertisementFirebaseRepositoryImpl>(
        AdvertisementFirebaseRepositoryImpl());
  }
  if (!GetIt.I.isRegistered<AdvertisementServices>()) {
    GetIt.I.registerSingleton<AdvertisementServices>(AdvertisementServices(
        remoteRepo: GetIt.I.get<AdvertisementFirebaseRepositoryImpl>()));
  }

  if (!GetIt.I.isRegistered<TeamFirebaseRepositoryImpl>()) {
    GetIt.I.registerSingleton<TeamFirebaseRepositoryImpl>(
        TeamFirebaseRepositoryImpl());
  }

  if (!GetIt.I.isRegistered<TeamServices>()) {
    GetIt.I.registerSingleton<TeamServices>(
        TeamServices(remoteRepo: GetIt.I.get<TeamFirebaseRepositoryImpl>()));
  }
}
