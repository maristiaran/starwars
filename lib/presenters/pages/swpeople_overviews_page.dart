import 'package:desafio_urbetrack/application/swpeople/swpeople.dart';
import 'package:desafio_urbetrack/application/swpeople/swpeople_events.dart';
import 'package:desafio_urbetrack/application/swpeople/swpeople_state.dart';
import 'package:desafio_urbetrack/domain/starwars_character.dart';
import 'package:desafio_urbetrack/presenters/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SWPeopleOverviewsPage extends StatelessWidget {
  const SWPeopleOverviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Star wars'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<SWPeopleBloc, SWPeopleState>(
          listener: (context, state) {
            if (state.swpeopleStatus == SWPeopleStatus.details) {
              appRouter.goNamed('swpeople_details');
            } else if (state.swpeopleStatus == SWPeopleStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessageIfAny!)));
            }
          },
          builder: (context, state) {
            if (state.swpeopleStatus == SWPeopleStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.swpeopleStatus == SWPeopleStatus.loaded) {
              List<SWCharacter> swCharacters =
                  BlocProvider.of<SWPeopleBloc>(context)
                      .allSWPeople
                      .getNextElements(count: state.inc);
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is UserScrollNotification) {
                    if (notification.direction == ScrollDirection.reverse) {
                      BlocProvider.of<SWPeopleBloc>(context)
                          .add(GetNextSWPeopleEvent(count: 5));
                    } else if (notification.direction ==
                        ScrollDirection.forward) {
                      BlocProvider.of<SWPeopleBloc>(context)
                          .add(GetNextSWPeopleEvent(count: -5));
                    }
                  }
                  return true;
                },
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    String gender = swCharacters[index].gender;
                    Icon genderIcon;
                    if (gender == "male") {
                      genderIcon = const Icon(Icons.male_outlined);
                    } else if (swCharacters[index].gender == "female") {
                      genderIcon = const Icon(Icons.female_outlined);
                    } else {
                      genderIcon = const Icon(Icons.circle_outlined);
                    }
                    return ListTile(
                      leading: genderIcon,
                      title: Text(swCharacters[index].name),
                      subtitle: Text('${swCharacters[index].id} - $gender'),
                      onTap: () {
                        BlocProvider.of<SWPeopleBloc>(context).add(
                            EnterSWPeopleDetailsEvent(swCharacters[index]));
                      },
                      trailing: const Icon(Icons.arrow_circle_right_outlined),
                    );
                  },
                ),
              );
            } else {
              return const Text('error');
            }
          },
        ),
      ),
    );
  }
}
