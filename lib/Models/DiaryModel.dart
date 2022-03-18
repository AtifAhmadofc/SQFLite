class DiaryModel {
  String title;
  String message;
  int? Id;

  DiaryModel({required this.title,required this.message,this.Id});

  factory DiaryModel.fromDb(data)=>DiaryModel(
      title: data["title"],
      Id: data["Id"],
    message: data["message"]
  );
}
