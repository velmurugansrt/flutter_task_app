import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_task_app/src/constants/app_constants.dart';
import 'package:flutter_task_app/src/data/notification/push_notification.dart';
import 'package:flutter_task_app/src/data/repository/dashboard/dashboard_repository.dart';
import 'package:flutter_task_app/src/models/dashboard/task_list_reponse_model.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  @override
  DashboardInitialState get initialState => DashboardInitialState();
  DashboardTaskListState dashboardTaskListState = DashboardTaskListState();

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is DahsboardFetchTaskListEvent) {
      yield* _handleDahsboardFetchTaskListEvent(event);
    } else if (event is DashboardSortingEvent) {
      yield* _handleDashboardSortingEvent(event);
    } else if (event is DashboardListUpdateEvent) {
      dashboardTaskListState..taskList = event.tasksList;
      yield* _handleSorting();
    } else if (event is DashboardFailedEvent) {
      yield DashboardFailedState(event.message);
    } else if (event is DashboardTaskLisReadEvent) {
      List<TasksList> taskList = dashboardTaskListState.taskList;
      taskList.forEach((newTaskItem) {
        newTaskItem.read = true;
        return newTaskItem;
      });
      yield DashboardChangeState();
      yield dashboardTaskListState..taskList = taskList;
    }
  }

  Stream<DashboardState> _handleDahsboardFetchTaskListEvent(
      DahsboardFetchTaskListEvent event) async* {
    yield DashboardLoaderState();
    Timer.periodic(Duration(seconds: 4), (timer) async {
      TaskListResponseModel data = await DashboardRepository().fetchRequest();
      if (data.isSuccess()) {
        List<TasksList> oldList = dashboardTaskListState.taskList;
        if (oldList == null || oldList.length != data.tasksList.length) {
          List<TasksList> totalTaskList = List<TasksList>();
          if (oldList != null) {
            data.tasksList.forEach((TasksList newTaskItem) {
              int findIndex =
                  oldList.indexWhere((element) => element.id == newTaskItem.id);
              if (findIndex != -1) {
                newTaskItem.read = oldList[findIndex].read;
                totalTaskList.add(newTaskItem);
              } else {
                Map payload = {
                  'notification': {
                    'title': newTaskItem.name,
                    'body': newTaskItem.info
                  },
                  'data': newTaskItem
                };
                PushNotification().showLocalNotification(payload);
                totalTaskList.add(newTaskItem);
              }
              return newTaskItem;
            });
          } else {
            totalTaskList = data.tasksList;
          }

          add(DashboardListUpdateEvent(totalTaskList));
        }
      } else {
        add(DashboardFailedEvent(data.message));
      }
    });
  }

  Stream<DashboardState> _handleDashboardSortingEvent(
      DashboardSortingEvent event) async* {
    dashboardTaskListState
      ..sorting = dashboardTaskListState.sorting == null
          ? true
          : !dashboardTaskListState.sorting;
    yield* _handleSorting();
  }

  Stream<DashboardState> _handleSorting() async* {
    final bool isAscending = dashboardTaskListState.sorting;
    final List<TasksList> taskList = dashboardTaskListState.taskList;
    if (isAscending == true) {
      taskList.sort((TasksList a, TasksList b) => AppConstants
          .PRIORITY_OBJECT[a.priority]
          .compareTo(AppConstants.PRIORITY_OBJECT[b.priority]));
    } else if (isAscending == false) {
      taskList.sort((TasksList a, TasksList b) => AppConstants
          .PRIORITY_OBJECT[b.priority]
          .compareTo(AppConstants.PRIORITY_OBJECT[a.priority]));
    }
    yield DashboardChangeState();
    yield dashboardTaskListState..taskList = taskList;
  }
}
