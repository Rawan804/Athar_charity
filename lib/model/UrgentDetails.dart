class Urgentdetails{

final String imageUrl;
final String name;
final int id;
final String location;
final double required_amount;
final double collected_amount;
final double remaining_amount;
final String startDate;
final String endDate;

Urgentdetails({
  required this.imageUrl,
  required this.name,
  required this.id,
required this.location,
  required this.required_amount,
  required this.collected_amount,
  required this.remaining_amount,
  required this.startDate,
  required this.endDate,
});
factory Urgentdetails.fromJson(Map<String, dynamic> json) {
  return Urgentdetails(
    imageUrl: json['image'],
    name: json['name'],
    id: json['id'],
    location: json['location'],
    required_amount: (json['required_amount'] is int)
        ? (json['required_amount'] as int).toDouble()
        : double.tryParse(json['required_amount'].toString()) ?? 0.0,

    collected_amount: (json['collected_amount'] is int)
     ?(json['collected_amount'] as int).toDouble()
     : double.tryParse(json['collected_amount'].toString())??0.0,

    remaining_amount: (json['remaining_amount'] is int)
        ?(json['remaining_amount'] as int).toDouble()
        : double.tryParse(json['remaining_amount'].toString())??0.0,

    startDate: json['startDate'],
    endDate: json['endDate'],
  );
}
double get timeProgress {
  try {
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    DateTime now = DateTime.now();

    final total = end.difference(start).inSeconds;
    final passed = now.difference(start).inSeconds;

    if (total <= 0) return 0.0;
    return (passed / total).clamp(0.0, 1.0);
  } catch (e) {
    print('Error in timeProgress: $e');
    return 0.0;
  }
}




}