import 'package:desafio_startwars/application/swpeople/swpeople.dart';
import 'package:desafio_startwars/application/swpeople/swpeople_events.dart';
import 'package:desafio_startwars/application/swpeople/swpeople_state.dart';
import 'package:desafio_startwars/bindings_and_tools.dart';
import 'package:desafio_startwars/domain/sighting_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SWPeopleDetailsPage extends StatelessWidget {
  const SWPeopleDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
      ),
      body: BlocBuilder<SWPeopleBloc, SWPeopleState>(builder: (context, state) {
        onReportSighting() async {
          if (state.isConnectionActive) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('La conección esta inactiva')));
          }

          (await starwarsRepository.reportSighting(
                  sWSightingReport: SWSightingReport(
                      userId: state.selectedSWCharacterIfAny!.id,
                      characterName: state.selectedSWCharacterIfAny!.name,
                      dateTime: DateTime.now().toString())))
              .fold(
                  (error) => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('¡Error!'),
                          backgroundColor: Colors.red)),
                  (success) => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('¡Reporte enviado!'),
                          backgroundColor: Colors.green)));
        }

        if (state.swpeopleStatus == SWPeopleStatus.details) {
          return WillPopScope(
              onWillPop: () async {
                BlocProvider.of<SWPeopleBloc>(context)
                    .add(ExitSWPeopleDetailsEvent());
                return true;
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                            leading: const Icon(Icons.label),
                            title: Text(state.selectedSWCharacterIfAny!.name),
                            subtitle: const Text('name')),
                        ListTile(
                            leading: const Icon(Icons.label),
                            title: Text(state.selectedSWCharacterIfAny!.gender),
                            subtitle: const Text('gender')),
                        ListTile(
                            leading: const Icon(Icons.label),
                            title: Text((state
                                        .selectedSWCharacterIfAny!.birthYear ==
                                    null)
                                ? '?'
                                : state.selectedSWCharacterIfAny!.birthYear!),
                            subtitle: const Text('birth year')),
                        // ListTile(
                        //     leading: const Icon(Icons.label),
                        //     title: Text(state.selectedSWCharacterIfAny!.height!
                        //         .toString()),
                        //     subtitle: const Text('birth year'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () => onReportSighting,
                          child: const Text('¡Reportar avistamiento!')),
                    ),
                  )
                ],
              ));
        } else {
          return const Text('??');
        }
      }),
    );
  }
}
