class PizzaModel {
  int? id;
  String? name;
  double? price;
  String? description;
  bool? prescence;
  String? consistance;
  int? sizeId;
  String? sizeName;
  String? photo;

  PizzaModel(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.prescence,
      this.consistance,
      this.sizeId,
      this.sizeName,
      this.photo});

  PizzaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    prescence = json['prescence'];
    consistance = json['consistance'];
    sizeId = json['sizeId'];
    sizeName = json['sizeName'];
    photo = json['photo'];
  }
}
