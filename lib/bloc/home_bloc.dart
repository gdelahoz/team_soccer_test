import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class HomeBLoC extends ChangeNotifier {
  HomeBLoC({required PersonServices personServices})
      : _personServices = personServices,
        super();

  final PersonServices _personServices;

  int indexSelected = 0;
  String firstText = "";
  String secondText = "";
  Player? person;

  void getUser(String email) async {
    person = await _personServices.getUser(email) as Player;
    notifyListeners();
  }

  void updateIndexSelected(int index) {
    indexSelected = index;
    updateText();
    notifyListeners();
  }

  void updateText() {
    switch (indexSelected) {
      case 0:
        firstText = "Eventos";
        secondText = "Importantes";
        break;
      case 1:
        firstText = "Bienvenido";
        secondText = person?.getFullName() ?? "";
        break;
      case 2:
        firstText = "Nuestro";
        secondText = "Equipo";
        break;
      default:
    }
  }
}
