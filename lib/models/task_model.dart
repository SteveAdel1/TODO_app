class TaskModel{
  String? id ;
  String title;
  String descreption;
  bool isDone;
  DateTime date;

  TaskModel({this.id,
    required this.title,
    required this.descreption,
    required this.isDone,
    required this.date});
  
  factory TaskModel.fromFirestore(Map<String,dynamic>json)=>TaskModel(title: json["title"],
      descreption: json["descreption"],
      isDone: json["isDone"],
      date: json["date"]);
}