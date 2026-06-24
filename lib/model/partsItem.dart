//
// class Project {
//   final String title;
//   final String image;
//   final List<DonationOption>? donationOptions;
//   final List<Map<String, dynamic>>? orphans;
//
//
//   Project({
//     required this.title,
//     required this.image,
//     this.donationOptions,
//     this.orphans,
//   });
// }
// class DonationOption {
//   final String location;
//   final String name;
//   final String image;
//   final double required_amount;
//   final List<String> needs;
//   final int? age; // ✅ العمر، مخصص لليتيم
//
//   DonationOption( {
//     required this.location,
//     required this.name,
//     required this.image,
//     required this.required_amount,
//     this.needs = const [],
//     this.age, // ✅ خاصية اختيارية
//   });
// }
class Project {
  final int id;
  final String name;
  final String image;

  Project({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
