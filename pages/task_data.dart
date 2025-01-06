class TaskData {
  final String id; // Unique identifier
  String taskText;
  bool isEditing;
  bool hideDeleteButton;
  bool isChecked;

  TaskData({
    required this.id,
    required this.taskText,
    required this.isEditing,
    required this.hideDeleteButton,
    this.isChecked = false,
  });

  // Override equality operator
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaskData &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}

