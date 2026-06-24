class Urgent {
  final String image;
  final String name;
   final int id;
  Urgent( {
    required this.image,
    required this.name,
    required this.id,
  });

  factory Urgent.fromJson(Map<String, dynamic> json) {
    return Urgent(
      id: json['id'],
      name: json['name'],
      image: json['image'] ?? '',
    );
  }



}
