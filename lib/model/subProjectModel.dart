class Subprojectmodel {
  final int project_id;
  final String name;
  final String image;
  final double required_amount;
  final int id;


  Subprojectmodel({
    required this.project_id,
    required this.name,
    required this.image,
    required this.required_amount,
    required this.id
  });

  factory Subprojectmodel.fromJson(Map<String, dynamic> json) {
    return Subprojectmodel(
      id: json['id'],
      project_id: json['project_id'],
      name: json['name'],
      image: json['image'] ,
      required_amount: (json['required_amount'] is int)
          ? (json['required_amount'] as int).toDouble()
          : double.tryParse(json['required_amount'].toString()) ?? 0.0,
    );
  }

}