class BasketModel {
  int? id;
  int? amount;
  double? price;
  int? userId;
  int? pizzaId;
  String? pizzaName;
  String? sizeName;

  BasketModel(
      {this.id,
      this.amount,
      this.price,
      this.userId,
      this.pizzaId,
      this.pizzaName,
      this.sizeName});

  BasketModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    price = json['price'];
    userId = json['userId'];
    pizzaId = json['pizzaId'];
    pizzaName = json['pizzaName'];
    sizeName = json['sizeName'];
  }
}
