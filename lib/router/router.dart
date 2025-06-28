import 'package:delflay_app/layout/layout_scaffold.dart';
import 'package:delflay_app/screens/home_screen.dart';
import 'package:delflay_app/screens/media_screen/media_screen.dart';
import 'package:delflay_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          LayoutScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => HomeScreen(),
              routes: [
                GoRoute(
                  path: ':mediaId',
                  builder: (context, state) => MediaScreen(
                    id: int.parse(state.pathParameters['mediaId']!),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
