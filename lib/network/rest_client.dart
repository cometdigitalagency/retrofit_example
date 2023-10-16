import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/todo.dart';
part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET('/todos')
  Future<List<Todo>> getTodos();

  @GET('/todos')
  Future<List<Todo>> getTodosByUserId(@Query('userId') int userId);

  @GET('/todos/{id}')
  Future<Todo> getTodoDetail(@Path('id') int id);

  @POST('/todos')
  Future<Todo> createTodo(@Body() Todo todo);

  @PUT('/todos/{id}')
  Future<Todo> updateTodo(@Path('id') int id, @Body() Todo todo);

  @PATCH('/todos/{id}')
  Future<Todo> updateTodoPart(
      @Path('id') int id, @Body() Map<String, dynamic> map);

  @DELETE('/todos/{id}')
  Future<void> deleteTodo(@Path('id') int id);
}
