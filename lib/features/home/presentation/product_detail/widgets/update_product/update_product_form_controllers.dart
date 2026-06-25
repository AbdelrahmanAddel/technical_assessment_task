import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product_detail.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/update_product_params.dart';

final class UpdateProductFormControllers {
  UpdateProductFormControllers._({
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.color,
    required this.discount,
  });

  final TextEditingController name;
  final TextEditingController description;
  final TextEditingController price;
  final TextEditingController stock;
  final TextEditingController color;
  final TextEditingController discount;

  factory UpdateProductFormControllers.fromProduct(ProductDetail product) {
    return UpdateProductFormControllers._(
      name: TextEditingController(text: product.name),
      description: TextEditingController(text: product.description),
      price: TextEditingController(text: product.price.toStringAsFixed(0)),
      stock: TextEditingController(text: product.stock.toString()),
      color: TextEditingController(text: product.color),
      discount: TextEditingController(
        text: product.discountPercentage.toString(),
      ),
    );
  }

  UpdateProductParams toParams() {
    return UpdateProductParams(
      name: name.text.trim(),
      description: description.text.trim(),
      price: double.parse(price.text.trim()),
      stock: int.parse(stock.text.trim()),
      color: color.text.trim(),
      discountPercentage: int.parse(discount.text.trim()),
    );
  }

  void dispose() {
    name.dispose();
    description.dispose();
    price.dispose();
    stock.dispose();
    color.dispose();
    discount.dispose();
  }
}
