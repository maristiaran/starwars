import 'package:desafio_urbetrack/domain/responses.dart';
import 'package:desafio_urbetrack/domain/sighting_report.dart';
import 'package:desafio_urbetrack/domain/starwars_character.dart';
import 'package:either_dart/either.dart';

abstract class StarwarsRepositoryPort {
  Stream<Either<SWPeopleError, List<SWCharacter>>> fetchSWPeopleOverviews();
  Future<Either<SWPeopleError, SWCharacter>> fetchSWPeopleDetails(
      {required SWCharacter swCharacter});
  Future<Either<SWPeopleError, Success>> reportSighting(
      {required SWSightingReport sWSightingReport});
}
