final class UpdateProductParams {
  const UpdateProductParams({
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.color,
    required this.discountPercentage,
  });

  final String name;
  final String description;
  final double price;
  final int stock;
  final String color;
  final int discountPercentage;
}
