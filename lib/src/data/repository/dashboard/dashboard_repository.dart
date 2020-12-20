import 'package:flutter_task_app/src/constants/api_services_urls.dart';
import 'package:flutter_task_app/src/data/network/http_client.dart';
import 'package:flutter_task_app/src/models/dashboard/task_list_reponse_model.dart';

class DashboardRepository {
  Future<TaskListResponseModel> fetchRequest() async {
    final Map resp =
        await HTTPClient().getJSONRequest(url: ApiServiceUrls.getJson);
    return TaskListResponseModel.fromJson(resp);
  }
}
