import 'package:create_todo_app/models/task.dart';
import 'package:scoped_model/scoped_model.dart';

class ScopedTasks extends Model {
  List<Task> tasks = [];
}
