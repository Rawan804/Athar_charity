// import '../../model/voulnteerModel.dart';
// import '../../voulnteer.dart';
//
// class Voulnteer_State{}
// class Voulnteer_Loading extends Voulnteer_State
// {
//
// }
//
// class Voulnteer_Succsess extends Voulnteer_State{
//   final List<Campaign> campaigns;
//   Voulnteer_Succsess(this.campaigns);}
// class Voulnteer_Failure extends Voulnteer_State{}
//
// class Voulnteer_SelectSuccess extends Voulnteer_State {
//   final Campaign campaign;
//   Voulnteer_SelectSuccess(this.campaign);
// }


import '../../model/ModVolunteer.dart';

class VolunteerState{

}
class VolunteerLoaded extends VolunteerState{

}

class VolunteerSucsess extends VolunteerState{
  final List<VolunteerRole> Roles;

  VolunteerSucsess(this.Roles);

}


class VolunteerFaliure extends VolunteerState{
  String message ;
  VolunteerFaliure(this.message);
}

class VolunteerSelectSuccess  extends VolunteerState{
  final VolunteerRole MV;

  VolunteerSelectSuccess(this.MV);
}


