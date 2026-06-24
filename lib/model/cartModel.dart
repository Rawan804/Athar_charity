class SubProjectInCart {
  final int id;

  final String name;
  final String image;
  final double amount;

  SubProjectInCart({
    required this.id,
    required this.name,
    required this.image,
    required this.amount,
  });

  factory SubProjectInCart.fromJson(Map<String, dynamic> json) {
    return SubProjectInCart(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
    );
  }
}
class CartModel {
  final int cart_id;
  final List<SubProjectInCart> subProjects;
  final List<dynamic> campaigns; // بما إنو فاضية حالياً
  final double totalAmount;

  CartModel({
    required this.cart_id,
    required this.subProjects,
    required this.campaigns,
    required this.totalAmount,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cart_id: int.tryParse(json['cart_id'].toString()) ?? 0,

      subProjects: (json['sub_projects'] as List)
          .map((e) => SubProjectInCart.fromJson(e))
          .toList(),
      campaigns: json['campaigns'],
      totalAmount: double.parse(json['total_amount'].toString()),
    );
  }
}
