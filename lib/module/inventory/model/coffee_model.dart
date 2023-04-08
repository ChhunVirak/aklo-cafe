class CoffeeModel {
  String name;
  String image;
  num unitPrice;
  int qty;
  int? id;

  CoffeeModel({
    required this.name,
    required this.image,
    required this.unitPrice,
    required this.qty,
    this.id,
  });
}
