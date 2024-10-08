import 'package:desafio_startwars/repositories/starwars_repository_rest_adapter.dart';
import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(headers: {"Content-Type": "application/json"}));
final starwarsRepository = StarwarsRepositoryRestAdapter();
