import 'package:json_annotation/json_annotation.dart';
part 'todo.g.dart';

@JsonSerializable()
class Todo {
  final int? id;
  final int userId;
  final String title;
  final bool completed;

  const Todo(
      {this.id,
      required this.userId,
      required this.title,
      required this.completed});
  // ເຊື່ອມຕໍ່ [_$TodoFromJson] ທີ່ໄດ້ຈາກການ generate ເຂົ້າກັບ fromJson
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  // ເຊື່ອມຕໍ່ [_$TodoToJson] ທີ່ໄດ້ຈາກການ generate ເຂົ້າກັບ toJson
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
