class VolunteerRole{
  final int id;
  final String name;
  final String image;
  final String location;


  VolunteerRole(
  {required this.id,
    required this.name,
   required this.image,
    required this.location,

  }
       );



  factory VolunteerRole.fromjson(Map<String,dynamic>json){

    return VolunteerRole(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      image: json['image'],

    );



  }



}

