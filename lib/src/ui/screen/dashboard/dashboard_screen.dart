import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_app/src/assets/styles/app_widget_size.dart';
import 'package:flutter_task_app/src/assets/theme/app_colors.dart';
import 'package:flutter_task_app/src/blocs/dashboard/dashboard_bloc.dart';
import 'package:flutter_task_app/src/constants/app_constants.dart';
import 'package:flutter_task_app/src/constants/app_text_constants.dart';
import 'package:flutter_task_app/src/data/notification/push_notification.dart';
import 'package:flutter_task_app/src/models/dashboard/task_list_reponse_model.dart';
import 'package:flutter_task_app/src/ui/navigation/screen_routes.dart';
import 'package:flutter_task_app/src/ui/screen/base/base_screen.dart';
import 'package:flutter_task_app/src/ui/widgets/common_appbar_widget.dart';
import 'package:flutter_task_app/src/ui/widgets/common_body_widget.dart';

class DashboardScreen extends BaseScreen {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends BaseScreenState<DashboardScreen> {
  DashboardBloc _dashboardBloc;
  @override
  void initState() {
    PushNotification().initLocalNotification();
    PushNotification().fetchNotification.listen(onNotification);
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      _dashboardBloc = BlocProvider.of<DashboardBloc>(context);
      _dashboardBloc.listen(_dashboardBlocListener);
      fetchTaskList();
    });
    super.initState();
  }

  void onNotification(dynamic data) {
    if (isScreenCurrent())
      Navigator.of(context).pushNamed(ScreenRoutes.TASK_SCREEN);
  }

  void _dashboardBlocListener(DashboardState state) {
    if (state is DashboardLoaderState) {
      startLoader();
    } else {
      stopLoader();
    }
    if (state is DashboardFailedState) {
      showAlert(state.msg);
    }
  }

  void fetchTaskList() {
    _dashboardBloc.add(DahsboardFetchTaskListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      condition: (DashboardState prevState, DashboardState currentState) {
        return currentState is DashboardTaskListState;
      },
      builder: (BuildContext bcxt, DashboardState state) {
        if (state is DashboardTaskListState) {
          final List<TasksList> taskList = state.taskList;
          final String count = taskList
              .where((TasksList element) => !element.read)
              .length
              .toString();
          return Scaffold(
            appBar: _buildAppbar(context, count),
            drawer: Container(),
            body: _buildBody(context),
          );
        }
        return Container();
      },
    );
  }

  AppBar _buildAppbar(BuildContext context, String count) {
    return commonAppbarWidget(
      AppTextConstants.DASHBOARD,
      count,
      callback,
      context,
    );
  }

  void callback(String type) {
    Navigator.of(context).pushNamed(ScreenRoutes.TASK_SCREEN);
  }

  Widget _buildBody(BuildContext context) {
    return commonBodyWidget(
      _buildTaskButton(),
      context,
    );
  }

  Center _buildTaskButton() {
    return Center(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: AppWidgetSize.buttonBorderRadius,
        ),
        color: AppColors.BUTTON_COLOR,
        child: const Text(
          AppConstants.TASKS,
        ),
        onPressed: onTaskPressed,
      ),
    );
  }

  void onTaskPressed() {
    Navigator.of(context).pushNamed(ScreenRoutes.TASK_SCREEN);
  }
}
