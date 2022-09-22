import 'package:desafio_urbetrack/domain/errors.dart';
import 'package:desafio_urbetrack/domain/startwars_repository.dart';
import 'package:desafio_urbetrack/domain/starwars_character.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import '../bindings_and_tools.dart';

class StarwarsRepositoryRestAdapter implements StarwarsRepositoryPort {
  String? _nextPageUrl = 'https://swapi.dev/api/people/?page=1';

  @override
  Stream<Either<SWPeopleError, List<SWCharacter>>>
      fetchSWPeopleOverviews() async* {
    int id = 0;
    while (_nextPageUrl != null) {
      Response response = await dio.get(_nextPageUrl!);

      if (response.statusCode == 200) {
        _nextPageUrl = response.data!['next'];
        List<dynamic> jsonPeople = response.data!['results'];
        // print(jsonPeople);
        yield Right(jsonPeople.map((swCharJson) {
          return SWCharacter.overview(
            id: ++id,
            name: swCharJson['name'],
            gender: swCharJson['gender'],
          );
        }).toList());
      } else {
        yield Left(SWPeopleError(SWPeopleErrors.networkConnection));
      }
    }
  }

  // bool noRemainsSWPeople() => _nextPageUrl == null;
  @override
  Future<Either<SWPeopleError, SWCharacter>> fetchSWPeopleDetails(
      {required SWCharacter swCharacter}) async {
    Response<Map<String, dynamic>> response =
        await dio.get('https://swapi.dev/api/people/${swCharacter.id}');
    if (response.statusCode == 200) {
      Map<String, dynamic> swCharJson = response.data!;

      return Right(swCharacter.loadDetails(
          birthYear: swCharJson['birth_year'],
          eyeColor: swCharJson['eye_color'],
          hairColor: swCharJson['hair_color'],
          height: int.parse(swCharJson['height']),
          homeworld: swCharJson['homeworld'],
          mass: int.parse(swCharJson['mass']),
          starships: [''],
          vehicles: ['']));
    } else {
      return Left(SWPeopleError(SWPeopleErrors.networkConnection));
    }
  }
}
