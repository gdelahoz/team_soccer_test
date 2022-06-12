import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class AdvertisementBLoC extends ChangeNotifier {
  AdvertisementBLoC({required AdvertisementServices advertisementServices})
      : _advertisementServices = advertisementServices,
        super();

  final AdvertisementServices _advertisementServices;
  Advertisements? adv = Advertisements(title: "", content: "", uid: "");

  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();

  Future<Advertisements?> getAdvertisement() async {
    try {
      adv = await _advertisementServices.getAdversiment();
      notifyListeners();
    } catch (e) {
      notifyListeners();
      print(e);
    }
    return null;
  }
}
