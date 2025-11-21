class MenuModel {
  final String id;
  final String name;
  final double price;
  final String category;
  final double discount; // 0–1

  MenuModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.discount = 0.0,
  });

  /// Harga setelah diskon
  double getDiscountedPrice() {
    return price - (price * discount);
  }

  int getDiscountedPriceInt() {
    return getDiscountedPrice().round();
  }
}
