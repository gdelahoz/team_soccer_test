import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:team_soccer/bloc/event_bloc.dart';

class EventScreen extends StatelessWidget {
  const EventScreen._();
  static Widget init() {
    return ChangeNotifierProvider(
      create: (_) => EventBLoC(eventServices: GetIt.I.get<EventServices>())
        ..getAllEvents(),
      builder: (_, __) => EventScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<EventBLoC>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: Stack(children: [
        Column(
          children: [
            _FilterEvent(context),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await bloc.getAllEvents();
                },
                child: bloc.eventsList.isEmpty
                    ? _EmptyEvent()
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: bloc.eventsList.length,
                        itemBuilder: (context, index) {
                          return _ItemEvent(event: bloc.eventsList[index]);
                        }),
              ),
            ),
          ],
        ),
        Positioned.fill(
            child: (bloc.state == EventState.loading)
                ? Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox.shrink())
      ]),
    );
  }
}

class _FilterEvent extends StatefulWidget {
  const _FilterEvent(BuildContext context);

  @override
  State<_FilterEvent> createState() => _FilterEventState();
}

class _FilterEventState extends State<_FilterEvent> {
  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
      final bloc = context.read<EventBLoC>();
      DateTime currentDate = DateTime.now();
      pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(currentDate.year),
          lastDate: currentDate);

      if (pickedDate != null && pickedDate != currentDate) {
        setState(() {
          currentDate = pickedDate!;
        });
        bloc.updateDateAndFetchDatah(pickedDate!);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Calendario",
            style: TextStyle(
                color: Color(0xff152D93),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () => _selectDate(context),
            child: Text(
                DateFormat.MMMEd('es').format(pickedDate ?? DateTime.now()),
                style: const TextStyle(
                    color: Color(0xff152D93),
                    fontSize: 19,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.underline)),
          ),
        ],
      ),
    );
  }
}

class _ItemEvent extends StatelessWidget {
  final Event event;
  final GlobalKey _menuKey = GlobalKey();
  _ItemEvent({Key? key, required this.event}) : super(key: key);
  void _showAlertDialog(context) {
    final bloc = Provider.of<EventBLoC>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Razon de inasistencia"),
          content: TextField(
            controller: bloc.reason,
          ),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Enviar"),
              onPressed: () async {
                bloc.iNoGo(event);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<EventBLoC>();
    return Container(
      child: Container(
          constraints: const BoxConstraints.expand(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(event.getImageEvent())),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2, left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.getNameEvent(),
                          style: const TextStyle(
                              color: Color(0xff152D93),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          DateFormat.MMMMEEEEd("es")
                              .format(event.getDateEvent()),
                          style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xff4E4957),
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 2.0,
                          width: 120,
                          color: const Color(0xFFE1E8E8),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          event.getPlaceOfEvent(),
                          style: const TextStyle(
                              color: Color(0xFF4E4957), fontSize: 13),
                        ),
                        Text(
                            "${DateFormat.jm().format(event.getStartEvent())} - ${DateFormat.jm().format(event.getEndEvent())}",
                            style: const TextStyle(
                                color: Color(0xFF4E4957), fontSize: 13)),
                        Text(
                            "${event.getConfirmedPlayers().length} asistentes",
                            style: const TextStyle(
                                color: Color(0xFF4E4957), fontSize: 13))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Column(
                    children: [
                      PopupMenuButton<String>(
                        onSelected: (value) => bloc.iGo(event),
                        key: _menuKey,
                        icon: const Icon(Icons.more_vert,
                            color: Color(0xff4E4957)),
                        iconSize: 23,
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: "asistire",
                            child: Text('Asistiré'),
                          ),
                          PopupMenuItem(
                            child: const Text("No asistiré"),
                            onTap: () {
                              Future<void>.delayed(const Duration(),
                                  () => _showAlertDialog(context));
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
      height: 134.0,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
        /*boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],*/
      ),
    );
  }
}

class _EmptyEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.campaign_rounded,
            size: 90,
            semanticLabel: "No eventos",
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "No hay eventos disponibles en la fecha seleccionada",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
