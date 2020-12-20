part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class DahsboardFetchTaskListEvent extends DashboardEvent {}

class DashboardTaskLisReadEvent extends DashboardEvent {}

class DashboardSortingEvent extends DashboardEvent {}

class DashboardListUpdateEvent extends DashboardEvent {
  List<TasksList> tasksList;
  DashboardListUpdateEvent(this.tasksList);
}

class DashboardFailedEvent extends DashboardEvent {
  String message;
  DashboardFailedEvent(this.message);
}
