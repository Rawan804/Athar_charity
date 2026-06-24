class AchievementsDetailsModel{
  final int id;
  final String title;
  final String description;
  final String location;
  final String image;
  AchievementsDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.image
});
  factory AchievementsDetailsModel.fromjson(Map<String,dynamic>json){
    return AchievementsDetailsModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        location: json['location'],
        image: json['image']);
  }


}