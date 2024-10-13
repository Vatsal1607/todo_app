// New model with fields (dueDate, priorities)
class TodoModel {
  int? userId;
  int? id;
  String? title;
  bool? completed;
  String? dueDate; // New field for due date
  String? priorities; // New field for priorities

  TodoModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
    this.dueDate,
    this.priorities,
  });

  TodoModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
    dueDate = json['dueDate']; // Deserialize the due date
    priorities = json['priorities']; // Deserialize the priorities
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['completed'] = completed;
    data['dueDate'] = dueDate; // Serialize the due date
    data['priorities'] = priorities; // Serialize the priorities
    return data;
  }
}


/// Previous default model
// class TodoModel {
//   int? userId;
//   int? id;
//   String? title;
//   bool? completed;
//
//   TodoModel({this.userId, this.id, this.title, this.completed});
//
//   TodoModel.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     id = json['id'];
//     title = json['title'];
//     completed = json['completed'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['userId'] = userId;
//     data['id'] = id;
//     data['title'] = title;
//     data['completed'] = completed;
//     return data;
//   }
// }
