import 'package:flutter/material.dart';
import 'package:flutter_task_app/src/assets/styles/app_widget_size.dart';
import 'package:flutter_task_app/src/assets/theme/app_colors.dart';
import 'package:flutter_task_app/src/constants/app_constants.dart';
import 'package:flutter_task_app/src/constants/app_text_constants.dart';
import 'package:flutter_task_app/src/ui/navigation/screen_routes.dart';
import 'package:flutter_task_app/src/ui/widgets/common_appbar_widget.dart';
import 'package:flutter_task_app/src/ui/widgets/common_body_widget.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      drawer: Container(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return commonAppbarWidget(
      AppTextConstants.DASHBOARD,
      '0',
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
