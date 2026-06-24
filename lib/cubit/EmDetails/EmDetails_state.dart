
import '../../model/UrgentDetails.dart';

class EmdetailsState{

}
class EmdetailsStateLoading extends EmdetailsState{

}
class EmdetailsStateSuccses extends EmdetailsState{
final Urgentdetails URG;
EmdetailsStateSuccses(this.URG);
}
class EmdetailsStateFailure extends EmdetailsState{

}