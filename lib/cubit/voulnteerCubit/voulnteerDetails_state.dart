// import '../../model/voulnteerModel.dart';
// class VoulnteerDetailsState {}
// class VoulnteerDetailsLoading extends VoulnteerDetailsState{}
// class VoulnteerDetailsSuccsess extends VoulnteerDetailsState{
//   final Campaign campaign;
//   VoulnteerDetailsSuccsess(this.campaign);
// }
// class VoulnteerDetailsFailure extends VoulnteerDetailsState{}


import '../../model/VolunteerDetails.dart';

class VolunterDetailsState{

}
class VolunterDetailsLoading extends VolunterDetailsState{

}
class VolunterDetailsSuccses extends VolunterDetailsState{
  final VolunteerDetail Role2;
  VolunterDetailsSuccses(this.Role2);
}
class VolunterDetailsFailure extends VolunterDetailsState{
  final String message;
  VolunterDetailsFailure(this.message);
}