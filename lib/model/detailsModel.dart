class DetailsModel {
  final int id;
  final String name;
  final String image;
  final String location;
  final List<String> needs;
  final double requiredAmount;
  final double collectedAmount;
  final double remainingAmount;
  final int status;
  final List<Map<String, String>> details;

  DetailsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
    required this.needs,
    required this.requiredAmount,
    required this.collectedAmount,
    required this.remainingAmount,
    required this.status,
    required this.details,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      location: json['location'],
      needs: (json['needs'] as String).split(RegExp(r'\s{2,}')).where((s) => s.isNotEmpty).toList(),
      requiredAmount: double.tryParse(json['required_amount'].toString()) ?? 0.0,
      collectedAmount: double.tryParse(json['collected_amount'].toString()) ?? 0.0,
      remainingAmount: double.tryParse(json['remaining_amount'].toString()) ?? 0.0,
      status: json['status'],
      details: (json['details'] as List<dynamic>? ?? [])
          .map((item) => {
        'key': item['key']?.toString() ?? '',
        'value': item['value']?.toString() ?? '',
      })
          .toList(),

    );
  }
}
