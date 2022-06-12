import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:infrastructure/advertisement/anticorruption/advertisement_translator.dart';
import 'package:infrastructure/advertisement/dto/advertisements.dart'
    as adver_firebase;

class AdvertisementFirebaseRepositoryImpl
    extends AdvertisementsFirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Advertisements?> getAdvertisement() async {
    Advertisements? adver;
    final advertisement =
        _firestore.collection("Advertisements").doc("qW4p0Z7s4vvTQWmuPLIl");
    await advertisement.get().then((value) {
      final adver_firebase.Advertisements ad =
          adver_firebase.Advertisements.fromFirestore(
              value.data() as Map<String, dynamic>);
      adver = AdvertisementTranslator.firebaseToDomain(ad);
    });

    return adver;
  }
}
