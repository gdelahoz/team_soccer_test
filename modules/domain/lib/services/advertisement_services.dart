import 'package:domain/domain.dart';

class AdvertisementServices {
  AdvertisementServices({required AdvertisementsFirebaseRepository remoteRepo})
      : _remoteRepo = remoteRepo,
        super();

  final AdvertisementsFirebaseRepository _remoteRepo;

  Future<Advertisements?> getAdversiment() async {
    return await _remoteRepo.getAdvertisement();
  }
}
