import 'package:domain/domain.dart';

class EventServices {
  EventServices({required EventRepository remoteRepo})
      : _remoteRepo = remoteRepo,
        super();

  final EventRepository _remoteRepo;

  Future<List<Event>> getAll(DateTime date) async {
    return await _remoteRepo.getAll(date) as List<Event>;
  }

  iGoToEvent(Event event) async {
    return await _remoteRepo.iGoToEvent(event);
  }

  iNoGoToEvent(Event event, String reason) async {
    return await _remoteRepo.iNoGoToEvent(event, reason);
  }
}
