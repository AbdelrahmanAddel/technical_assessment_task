final class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.coverPictureUrl,
    required this.price,
    required this.rating,
    required this.reviewsCount,
    required this.discountPercentage,
  });

  final String id;
  final String name;
  final String description;
  final String coverPictureUrl;
  final double price;
  final double rating;
  final int reviewsCount;
  final int discountPercentage;

  double get finalPrice {
    if (discountPercentage <= 0) return price;
    return price * (1 - discountPercentage / 100);
  }

  bool get hasDiscount => discountPercentage > 0;
}
