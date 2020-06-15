class Product {
  String name;
  double price;
  String category;

  Product({this.name, this.price, this.category});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      category: json['category'],
    );
  }
}
