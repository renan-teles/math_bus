import 'package:go_router/go_router.dart';
import 'package:math_bus/app/main_page.dart';
import 'package:math_bus/features/exercise/domain/exercise/exercise_config.dart';
import 'package:math_bus/features/exercise/domain/exercise/basic/operation.dart';
import 'package:math_bus/features/exercise/presentation/pages/basic_exercise/basic_exercise_page.dart';
import 'package:math_bus/features/exercise/presentation/pages/basic_exercise/config_basic_exercise_page.dart';
import 'package:math_bus/features/public/presentation/pages/about_page.dart';
import 'package:math_bus/features/public/presentation/pages/home_page.dart';

final router = GoRouter(
  initialLocation: '/',

  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainPage(navigationShell: navigationShell);
      },

      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) {
                return const HomePage();
              },
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/about',
              builder: (context, state) {
                return const AboutPage();
              },
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/exercises/config',
              builder: (context, state) {
                final operation = state.extra as Operation;
                return ConfigExercisePage(operation: operation);
              },
            ),

            GoRoute(
              path: '/exercises/basic',
              builder: (context, state) {
                final config = state.extra as ExerciseConfig;

                return BasicExercisePage(config: config);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
