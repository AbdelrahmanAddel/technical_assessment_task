import 'package:flutter/material.dart';

class ProductsLoadingView extends StatelessWidget {
  const ProductsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
