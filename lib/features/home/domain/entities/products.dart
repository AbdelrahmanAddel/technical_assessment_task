import 'product.dart';

final class Products {
  const Products({
    required this.items,
    required this.page,
    required this.hasNextPage,
  });

  final List<Product> items;
  final int page;
  final bool hasNextPage;
}
