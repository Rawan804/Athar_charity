class Achievements {
  final int id;
  final String title;
  final String image;

  Achievements({
    required this.id,
    required this.title,
    required this.image
  });

  factory Achievements.fromJson(Map<String, dynamic>json){
    return Achievements(
        id:json ['id'],
        title: json['title'],
        image: json['image']);
  }
}