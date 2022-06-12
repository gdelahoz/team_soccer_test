import 'package:domain/domain.dart';

abstract class EventRepository<T> {
  Future<List<T>> getAll(DateTime date);
  Future iGoToEvent(Event event);
  Future iNoGoToEvent(Event event, String reason);
}
