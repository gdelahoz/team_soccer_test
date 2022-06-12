import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

enum EventState { loading, success, error }

class EventBLoC extends ChangeNotifier {
  EventBLoC({required EventServices eventServices})
      : _eventServices = eventServices,
        super();

  final EventServices _eventServices;
  final reason = TextEditingController();
  DateTime date = DateTime.now();
  List<Event> eventsList = <Event>[];
  var state = EventState.loading;

  Future getAllEvents() async {
    try {
      state = EventState.loading;
      eventsList = await _eventServices.getAll(date);
      state = EventState.success;
      notifyListeners();
    } catch (e) {
      state = EventState.error;
      print(e);
    }
  }

  void updateDateAndFetchDatah(DateTime dateCalendar) async {
    date = dateCalendar;
    await getAllEvents();
    notifyListeners();
  }

  iGo(Event event) async {
    await _eventServices.iGoToEvent(event);
    await getAllEvents();
    notifyListeners();
  }

  void iNoGo(Event event) async {
    await _eventServices.iNoGoToEvent(event, reason.text);
    await getAllEvents();
    notifyListeners();
  }
}
