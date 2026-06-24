import '../../model/Urgent.dart';


class EmergencyState{}
class EmergencyLoaded extends EmergencyState{

}
class EmergencySuccsess extends EmergencyState{
  final List<Urgent>Urgents;

  EmergencySuccsess(this.Urgents);

}
class EmergencyFailure extends EmergencyState{
String message;
EmergencyFailure(this.message);
}

class EmergencySelectSuccess extends EmergencyState {
  final Urgent Ur;
  EmergencySelectSuccess(this.Ur);

}