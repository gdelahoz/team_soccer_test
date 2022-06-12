import 'package:domain/event/entities/event.dart' as EventDomain;
import 'package:domain/event/entities/event_training.dart' as EventTraining;
import 'package:infrastructure/event/dto/event_dto.dart' as EventFirebase;

class EventTraslator {
  static EventFirebase.EventDTO fromDomainToDto(EventDomain.Event event) {
    EventFirebase.EventDTO eventDTO = EventFirebase.EventDTO(
        uid: event.getUidEvent(),
        confirmedPlayer: event.getConfirmedPlayers(),
        imageEvent: event.getImageEvent(),
        dateEvent: event.getDateEvent(),
        endEvent: event.getEndEvent(),
        locationEvent: event.getPlaceOfEvent(),
        nameEvent: event.getNameEvent(),
        startEvent: event.getStartEvent());
    return eventDTO;
  }

  static EventDomain.Event fromDTOToDomain(EventFirebase.EventDTO event) {
    EventDomain.Event eventDTO = EventTraining.EventTraining(
        uid: event.uid,
        typeEvent: 0,
        confirmedPlayers: event.confirmedPlayer,
        imageEvent: event.imageEvent,
        dateEvent: event.dateEvent,
        endTime: event.endEvent,
        placeEvent: event.locationEvent,
        nameEvent: event.nameEvent,
        startTime: event.startEvent);
    return eventDTO;
  }
}
