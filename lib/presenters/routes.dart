import 'package:desafio_urbetrack/presenters/pages/menu_page.dart';
import 'package:desafio_urbetrack/presenters/pages/swpeople_details_page.dart';
import 'package:desafio_urbetrack/presenters/pages/swpeople_overviews_page.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
        name: 'swpeople_list',
        path: '/',
        builder: (context, state) => const SWPeopleOverviewsPage(),
        routes: [
          GoRoute(
              name: 'swpeople_details',
              path: 'swpeople_details',
              builder: (context, state) => const SWPeopleDetailsPage()),
          GoRoute(
              name: 'menu',
              path: 'menu',
              builder: (context, state) => const MenuPage())
        ]),
  ],
);
