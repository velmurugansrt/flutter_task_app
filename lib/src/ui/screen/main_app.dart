import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_app/src/assets/theme/app_themes.dart';
import 'package:flutter_task_app/src/assets/theme/theme_bloc.dart';
import 'package:flutter_task_app/src/blocs/dashboard/dashboard_bloc.dart';
import 'package:flutter_task_app/src/data/store/app_store.dart';
import 'package:flutter_task_app/src/ui/navigation/screen_routes.dart';
import 'package:flutter_task_app/src/ui/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_task_app/src/ui/screen/tasks/tasks_screen.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (BuildContext context) => ThemeBloc(),
      child: AppRoutes(),
    );
  }
}

class AppRoutes extends StatefulWidget {
  AppRoutes({Key key}) : super(key: key);

  @override
  _AppRoutesState createState() => _AppRoutesState();
}

class _AppRoutesState extends State<AppRoutes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        return BlocProvider<DashboardBloc>(
          create: (BuildContext context) => DashboardBloc(),
          child: MaterialApp(
            initialRoute: ScreenRoutes.DASHBOARD_SCREEN,
            theme: AppTheme.themeManager(state.themeType),
            onGenerateRoute: generateRoute,
          ),
        );
      },
    );
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ScreenRoutes.DASHBOARD_SCREEN:
      return MaterialPageRoute<dynamic>(
        settings: const RouteSettings(name: ScreenRoutes.DASHBOARD_SCREEN),
        builder: (BuildContext context) {
          return DashboardScreen();
        },
      );
      break;
    case ScreenRoutes.TASK_SCREEN:
      return MaterialPageRoute<dynamic>(
        settings: const RouteSettings(name: ScreenRoutes.TASK_SCREEN),
        builder: (BuildContext context) {
          return TasksScreen();
        },
      );
      break;
    default:
      return MaterialPageRoute<dynamic>(
        settings: const RouteSettings(name: ScreenRoutes.DASHBOARD_SCREEN),
        builder: (BuildContext context) {
          return DashboardScreen();
        },
      );
      break;
  }
}
