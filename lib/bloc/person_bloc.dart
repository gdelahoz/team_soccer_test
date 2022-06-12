import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

enum LoginState { initial, loading, success, error }

class PersonBLoC extends ChangeNotifier {
  PersonBLoC({required PersonServices personServices})
      : _personServices = personServices,
        super();

  final PersonServices _personServices;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  var state = LoginState.initial;
  Player? person;

  Future<Person> login() async {
    try {
      state = LoginState.loading;
      final user = await _personServices.login(
          emailTextController.text, passwordTextController.text);
      state = LoginState.success;
      notifyListeners();
      return user;
    } catch (e) {
      print(e); 
      state = LoginState.error;
      notifyListeners();
      rethrow;
    }
  }
}
