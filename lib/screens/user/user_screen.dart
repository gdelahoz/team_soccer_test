import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:team_soccer/bloc/home_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen._(Person person);
  static Widget init(Person person) {
    return ChangeNotifierProvider(
      create: (_) => HomeBLoC(personServices: GetIt.I.get<PersonServices>())
        ..getUser(person.getEmail()),
      builder: (_, __) => UserScreen._(person),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBLoC>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: _SoccerAppBar(person: bloc.person),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _CardItem(
                height: 190,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Información personal",
                      style: TextStyle(
                          color: Color(0xff152D93),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Nombre:",
                      style: TextStyle(
                          color: Color(0xff4E4957),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(bloc.person?.getFullName() ?? "Nan",
                        style: const TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    const Text("Correo:",
                        style: TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text(bloc.person?.getEmail() ?? "Nan",
                        style: const TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    const Text("Telefono:",
                        style: TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text(bloc.person?.getCellPhone() ?? "Nan",
                        style: const TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                  ],
                )),
            _CardItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Información fisica",
                      style: TextStyle(
                          color: Color(0xff152D93),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Altura:",
                      style: TextStyle(
                          color: Color(0xff4E4957),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "${bloc.person?.getPhysicalInfo().getHeigth().toString()} KG",
                        style: const TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    const Text("Peso:",
                        style: TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text(
                        "${bloc.person?.getPhysicalInfo().getWeight().toString()} CM",
                        style: const TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    const Text("Edad:",
                        style: TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text(bloc.person?.getAge().toString() ?? "Nan",
                        style: const TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
                height: 190),
            _CardItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Datos del jugador",
                      style: TextStyle(
                          color: Color(0xff152D93),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Posición:",
                      style: TextStyle(
                          color: Color(0xff4E4957),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(bloc.person?.getPlayerData().getPosition() ?? "Nan",
                        style: const TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    const Text("Posición secundaria:",
                        style: TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text(
                        bloc.person?.getPlayerData().getSecondaryPosition() ??
                            "Nan",
                        style: const TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    const Text("Dorsal:",
                        style: TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text(
                        bloc.person?.getPlayerData().getDorsal().toString() ??
                            "Nan",
                        style: const TextStyle(
                            color: Color(0xff4E4957),
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
                height: 200),
            const SizedBox(height: 70)
          ],
        ),
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  final Widget child;
  final double height;
  const _CardItem({required this.child, required this.height});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      margin: const EdgeInsets.all(10),
      child: Container(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: child,
          ),
        ),
        height: height,
        margin: const EdgeInsets.all(10),
      ),
    );
  }
}

class _SoccerAppBar extends StatelessWidget with PreferredSizeWidget {
  final Player? person;
  _SoccerAppBar({required this.person});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 10, right: 15),
            child: Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Mi",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF152D93),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Perfil 🙍🏽‍♂️",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFFFE9402),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Spacer(),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(person?.getPhotoUrl() ?? ""),
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
