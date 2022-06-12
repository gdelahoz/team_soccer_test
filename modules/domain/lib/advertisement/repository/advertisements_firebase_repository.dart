import 'package:domain/advertisement/entities/advertisement.dart';

abstract class AdvertisementsFirebaseRepository<T extends Advertisements> {
  Future<T?> getAdvertisement();
}
