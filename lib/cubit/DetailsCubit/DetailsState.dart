

import '../../model/detailsModel.dart';

class DetailsState{}
class DetailsLoading extends DetailsState{
}
class DetailsSuccsess extends DetailsState{

  final DetailsModel projectd;
  DetailsSuccsess(this.projectd);
}
class DetailsFailure extends DetailsState{
  final String message;
  DetailsFailure(this.message);
}
class CartAdded extends DetailsState {}
