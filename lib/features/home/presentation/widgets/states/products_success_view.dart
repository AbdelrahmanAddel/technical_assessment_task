import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product.dart';
import 'package:flutter_techincal_test/features/home/presentation/cubit/products_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/product_card/product_card.dart';

class ProductsSuccessView extends StatelessWidget {
  const ProductsSuccessView({
    super.key,
    required this.scrollController,
    required this.products,
    required this.isLoadingMore,
    required this.isRefreshing,
  });

  final ScrollController scrollController;
  final List<Product> products;
  final bool isLoadingMore;
  final bool isRefreshing;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<ProductsCubit>().refreshProducts(),
      child: CustomScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (isRefreshing)
            const SliverToBoxAdapter(child: LinearProgressIndicator()),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: HomeDimension.gridHorizontalPadding,
              vertical: HomeDimension.gridVerticalPadding,
            ),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: HomeDimension.gridCrossAxisCount,
                crossAxisSpacing: HomeDimension.gridCrossAxisSpacing,
                mainAxisSpacing: HomeDimension.gridMainAxisSpacing,
                childAspectRatio: HomeDimension.productCardAspectRatio,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) =>
                  ProductCard(product: products[index]),
            ),
          ),
          if (isLoadingMore)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(
                  HomeDimension.loadMoreIndicatorPadding,
                ),
                child: Center(
                  child: SizedBox.square(
                    dimension: HomeDimension.loadMoreIndicatorSize,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: context.colors.primary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
