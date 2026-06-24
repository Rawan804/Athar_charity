class VolunteerDetail {
  final int id;
  final String name;
  final String image;
  final String location;
  final String startEndTime;
  final String startEndDate;
  final String description;
  final int status;

  VolunteerDetail({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
    required this.startEndTime,
    required this.startEndDate,
    required this.description,
    required this.status,
  });

  factory VolunteerDetail.fromJson(Map<String, dynamic> json) {
    return VolunteerDetail(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      location: json['location'],
      startEndTime: json['start_end_time'],
      startEndDate: json['start_end_date'],
      description: json['description'] ,
      status: json['status'],
    );
  }
}
