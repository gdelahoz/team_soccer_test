import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:infrastructure/event/anticorruption/event_traslator.dart';
import 'package:infrastructure/infrastructure.dart';

class EventFirebaseRepositoryImpl implements EventRepository<Event> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Event>> getAll(DateTime date) async {
    CollectionReference events = _firestore.collection('Events');
    List<Event> all = <Event>[];
    await events
        .where('dateEvent',
            isGreaterThanOrEqualTo:
                Timestamp.fromDate(DateTime(date.year, date.month, date.day)))
        .where('dateEvent',
            isLessThanOrEqualTo: Timestamp.fromDate(
                DateTime(date.year, date.month, date.day + 1)))
        .get()
        .then((value) => value.docs.forEach((element) {
              EventDTO eventDTO = EventDTO.fromFirestore(
                  element.data() as Map<String, dynamic>);
              var event = EventTraslator.fromDTOToDomain(eventDTO);
              all.add(event);
            }));
    return all;
  }

  Future updateData(Event event, [String? reason]) async {
    if (reason != null) {
      await _firestore.collection("Events").doc(event.getUidEvent()).update({
        "rejectedPlayers": FieldValue.arrayUnion(
            [_firestore.doc("Users/ejWGI3z7iTgrgNKn8AreMyvW9Is2,$reason")])
      });
    } else {
      await _firestore.collection("Events").doc(event.getUidEvent()).update({
        "confirmedPlayers": FieldValue.arrayUnion(
            [_firestore.doc("Users/ejWGI3z7iTgrgNKn8AreMyvW9Is2")])
      });
    }
  }

  @override
  Future iGoToEvent(Event event) async {
    await _firestore
        .collection("Events")
        .doc(event.getUidEvent())
        .get()
        .then((value) => {updateData(event)});
  }

  @override
  Future iNoGoToEvent(Event event, String reason) async {
    await _firestore
        .collection("Events")
        .doc(event.getUidEvent())
        .get()
        .then((value) => {updateData(event, reason)});
  }
}
