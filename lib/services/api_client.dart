import 'package:dio/dio.dart';
import 'package:todo_app/models/todo_model.dart';
import 'api_service.dart';

class ApiClient {
  late ApiService apiService;

  ApiClient() {
    final dio = Dio();
    apiService = ApiService(dio);
  }

  Future<List<TodoModel>> getTodoList() async {
    try {
      return await apiService.getTodoList();
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
