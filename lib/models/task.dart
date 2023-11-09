class Task {
  DateTime date;
  String text;
  bool isCompleted;
  Task(this.date, this.text, this.isCompleted);

  static List<Task> fetchAll() {
    Task t1 = Task(DateTime.now(), 'Test 1', false);
    Task t2 =
        Task(DateTime.now().add(const Duration(days: 1)), 'Test 2', false);
    return [t1, t2];
  }
}
