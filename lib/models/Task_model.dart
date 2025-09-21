class TaskModel {
  String id;
  String title;
  String description;
  int Date;
  bool isdone;
  String userId;

  TaskModel(
      {this.id = "",
      required this.title,
      required this.description,
      required this.Date,
      required this.userId,
      this.isdone = false,
      });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            title: json["title"],
            description: json["description"],
            Date: json["Date"],
            userId: json["userId"],
            isdone: json["isdone"],
            id: json["id"]);

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "Date": Date,
      "isdone": isdone,
      "id": id,
      "userId":userId
    };
  }
}