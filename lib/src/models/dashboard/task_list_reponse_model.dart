import 'package:flutter_task_app/src/models/base/base_model.dart';

class TaskListResponseModel extends BaseModel {
  List<TasksList> tasksList;

  TaskListResponseModel({this.tasksList});

  TaskListResponseModel.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    if (data['tasksList'] != null) {
      tasksList = List<TasksList>();
      data['tasksList'].forEach((v) {
        tasksList.add(TasksList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tasksList != null) {
      data['tasksList'] = this.tasksList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TasksList {
  String id;
  String name;
  String loc;
  String playTime;
  String taskType;
  String priority;
  String priorityLabel;
  String info;
  String creater;
  String createdOn;
  String status;
  bool read = false;

  TasksList({
    this.id,
    this.name,
    this.loc,
    this.playTime,
    this.taskType,
    this.priority,
    this.priorityLabel,
    this.info,
    this.creater,
    this.createdOn,
    this.status,
    this.read = false,
  });

  TasksList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    loc = json['loc'];
    playTime = json['playTime'];
    taskType = json['taskType'];
    priority = json['priority'];
    priorityLabel = json['priorityLabel'];
    info = json['info'];
    creater = json['creater'];
    createdOn = json['createdOn'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['loc'] = this.loc;
    data['playTime'] = this.playTime;
    data['taskType'] = this.taskType;
    data['priority'] = this.priority;
    data['priorityLabel'] = this.priorityLabel;
    data['info'] = this.info;
    data['creater'] = this.creater;
    data['createdOn'] = this.createdOn;
    data['status'] = this.status;
    return data;
  }
}
