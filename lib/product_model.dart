class Product{
  final String name;
  final String color;
  final String size;
  final String image;
  final int price;
  int quantity;
  int modeltotalPrice;
  
  Product(
  {required this.name,
    required this.color,
    required this.size,
    required this.image,
    required this.price,
    this.quantity = 0,
    this.modeltotalPrice = 0,
});
}
