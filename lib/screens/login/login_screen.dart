import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:team_soccer/bloc/person_bloc.dart';
import 'package:team_soccer/screens/home/home_screen.dart';
import 'package:team_soccer/widgets/soccer_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen._();

  static Widget init() {
    return ChangeNotifierProvider(
      create: (_) => PersonBLoC(personServices: GetIt.I.get<PersonServices>()),
      builder: (_, __) => const LoginScreen._(),
    );
  }

  void login(String email, String pass, BuildContext context) async {
    final bloc = Provider.of<PersonBLoC>(context, listen: false);
    try {
      final user = await bloc.login();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen.init(user)));
    } catch (e) {
      final messageError = e.toString().split("]");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(messageError[1].trim())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<PersonBLoC>();
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://images.pexels.com/photos/3651674/pexels-photo-3651674.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"), fit: BoxFit.cover)
                ),
            ),
            Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: 450,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("TEAM UP \n SOCCER",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: bloc.emailTextController,
                    decoration: InputDecoration(
                        hintText: "Correo",
                        hintStyle: const TextStyle(
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(Icons.person_outline,
                            color: Theme.of(context).iconTheme.color)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: bloc.passwordTextController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Contraseña",
                        hintStyle: const TextStyle(
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Theme.of(context).iconTheme.color!,
                        )),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(25),
                      child: SoccerButton(
                          text: 'INICIAR SESIÓN',
                          onTap: () => login("email", "pass", context)))
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
            )),
            Positioned.fill(
                child: (bloc.state == LoginState.loading)
                    ? Container(
                        color: Colors.black26,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : const SizedBox.shrink())
          ],
        ))
      ]),
    );
  }
}
