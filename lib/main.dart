import 'package:desafio_startwars/application/swpeople/swpeople.dart';
import 'package:desafio_startwars/domain/startwars_repository.dart';
import 'package:desafio_startwars/presenters/routes.dart';
import 'package:desafio_startwars/repositories/starwars_repository_rest_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // SWPeopleApp().initialize();
  runApp(const SWPeopleWidget());
}

class SWPeopleWidget extends StatelessWidget {
  const SWPeopleWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SWPeopleBloc>(
        create: (context) => SWPeopleBloc(
            StarwarsRepositoryRestAdapter() as StarwarsRepositoryPort),
        child: (MaterialApp.router(
            title: 'Flutter Authentication',
            routeInformationParser: appRouter.routeInformationParser,
            routerDelegate: appRouter.routerDelegate,
            routeInformationProvider: appRouter.routeInformationProvider,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 24.0,
                  ),
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                ),
              ),
              textTheme: TextTheme(
                displayMedium: TextStyle(
                  fontSize: 46.0,
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w500,
                ),
                displaySmall: const TextStyle(fontSize: 18.0),
              ),
            ))));
  }
}
