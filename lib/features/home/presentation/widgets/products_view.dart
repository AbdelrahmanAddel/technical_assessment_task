import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/features/home/presentation/cubit/products_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/cubit/products_state.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/states/products_empty_view.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/states/products_error_view.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/states/products_loading_view.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/states/products_success_view.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late final ScrollController _scrollController;
  double _lastCheckedScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final pixels = _scrollController.position.pixels;
    final scrollDelta = (pixels - _lastCheckedScrollOffset).abs();

    if (scrollDelta < HomeDimension.scrollCheckStep) return;

    _lastCheckedScrollOffset = pixels;

    context.read<ProductsCubit>().onScroll(
      pixels: pixels,
      maxScrollExtent: _scrollController.position.maxScrollExtent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return switch (state) {
          ProductsInitial() || ProductsLoading() => const ProductsLoadingView(),
          ProductsFailure(:final message) => ProductsErrorView(message: message),
          ProductsSuccess(
            :final products,
            :final isLoadingMore,
            :final isRefreshing,
          ) =>
            products.isEmpty
                ? const ProductsEmptyView()
                : ProductsSuccessView(
                    scrollController: _scrollController,
                    products: products,
                    isLoadingMore: isLoadingMore,
                    isRefreshing: isRefreshing,
                  ),
        };
      },
    );
  }
}
