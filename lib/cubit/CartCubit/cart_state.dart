
import '../../model/cartModel.dart';

class CartState {}

class CartLoading extends CartState {}


 class CartSuccsess extends CartState {
   final CartModel cart;



   CartSuccsess(this.cart);
 }

class CartFailure extends CartState{

}
