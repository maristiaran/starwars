import 'package:desafio_urbetrack/application/swpeople/swpeople.dart';
import 'package:desafio_urbetrack/application/swpeople/swpeople_events.dart';
import 'package:desafio_urbetrack/application/swpeople/swpeople_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SWPeopleDetailsPage extends StatelessWidget {
  const SWPeopleDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Star wars'),
      ),
      body: BlocBuilder<SWPeopleBloc, SWPeopleState>(builder: (context, state) {
        if (state.swpeopleStatus == SWPeopleStatus.details) {
          return WillPopScope(
              onWillPop: () async {
                BlocProvider.of<SWPeopleBloc>(context)
                    .add(ExitSWPeopleDetailsEvent());
                return true;
              },
              child: Text(state.selectedSWCharacterIfAny!.name));
        } else {
          return const Text('error');
        }
      }),
    );
  }
}
