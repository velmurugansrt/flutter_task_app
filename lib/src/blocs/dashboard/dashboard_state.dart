part of 'dashboard_bloc.dart';

abstract class DashboardState {}

class DashboardInitialState extends DashboardState {}

class DashboardChangeState extends DashboardState {}

class DashboardLoaderState extends DashboardState {}

class DashboardTaskListState extends DashboardState {
  List<TasksList> taskList;
  bool sorting;
}

class DashboardFailedState extends DashboardState {
  String msg;
  DashboardFailedState(this.msg);
}
