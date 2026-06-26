import 'package:flutter_techincal_test/features/home/domain/entities/product.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/products.dart';

const tProduct = Product(
  id: 'product-1',
  name: 'Product One',
  description: 'First product',
  coverPictureUrl: 'https://example.com/product-1.png',
  price: 99.99,
  rating: 4.5,
  reviewsCount: 10,
  discountPercentage: 10,
);

const tProductTwo = Product(
  id: 'product-2',
  name: 'Product Two',
  description: 'Second product',
  coverPictureUrl: 'https://example.com/product-2.png',
  price: 49.99,
  rating: 4.0,
  reviewsCount: 5,
  discountPercentage: 0,
);

const tProducts = Products(
  items: [tProduct],
  page: 1,
  hasNextPage: true,
);

const tProductsPageTwo = Products(
  items: [tProductTwo],
  page: 2,
  hasNextPage: false,
);

const tFailureMessage = 'Something went wrong';
