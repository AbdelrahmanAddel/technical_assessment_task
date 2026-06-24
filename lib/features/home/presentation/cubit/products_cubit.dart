import 'package:dartx/dartx.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_products_use_case.dart';
import '../home_dimen.dart';
import 'products_state.dart';

final class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required this.getProductsUseCase})
    : super(const ProductsInitial());

  final GetProductsUseCase getProductsUseCase;

  bool _isFetching = false;
  DateTime? _lastPaginationCall;

  void onScroll({
    required double pixels,
    required double maxScrollExtent,
  }) {
    final remainingScroll = maxScrollExtent - pixels;
    if (remainingScroll > HomeDimension.loadMoreTriggerOffset) return;

    final now = DateTime.now();
    final lastPaginationCall = _lastPaginationCall;

    if (lastPaginationCall != null &&
        now.difference(lastPaginationCall) <
            HomeDimension.paginationThrottleMs.milliseconds) {
      return;
    }

    _lastPaginationCall = now;
    loadMoreProducts();
  }

  Future<void> loadProducts() async {
    if (_isFetching) return;

    _isFetching = true;
    emit(const ProductsLoading());

    final result = await getProductsUseCase(
      page: HomeDimension.initialPage,
      pageSize: HomeDimension.pageSize,
    );

    _isFetching = false;

    result.fold(
      (failure) => emit(ProductsFailure(failure.errMessage)),
      (products) {
        emit(
          ProductsSuccess(
            products: products.items,
            hasNextPage: products.hasNextPage,
            currentPage: products.page,
          ),
        );
      },
    );
  }

  Future<void> refreshProducts() async {
    if (_isFetching) return;

    final currentState = state;
    if (currentState is ProductsSuccess) {
      emit(currentState.copyWith(isRefreshing: true));
    } else {
      emit(const ProductsLoading());
    }

    _isFetching = true;

    final result = await getProductsUseCase(
      page: HomeDimension.initialPage,
      pageSize: HomeDimension.pageSize,
    );

    _isFetching = false;

    result.fold(
      (failure) {
        if (currentState is ProductsSuccess) {
          emit(currentState.copyWith(isRefreshing: false));
          return;
        }
        emit(ProductsFailure(failure.errMessage));
      },
      (products) {
        emit(
          ProductsSuccess(
            products: products.items,
            hasNextPage: products.hasNextPage,
            currentPage: products.page,
          ),
        );
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (_isFetching) return;

    final currentState = state;
    if (currentState is! ProductsSuccess) return;
    if (!currentState.hasNextPage || currentState.isLoadingMore) return;

    _isFetching = true;
    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.currentPage + 1;
    final result = await getProductsUseCase(
      page: nextPage,
      pageSize: HomeDimension.pageSize,
    );

    _isFetching = false;

    result.fold(
      (failure) => emit(currentState.copyWith(isLoadingMore: false)),
      (products) {
        emit(
          ProductsSuccess(
            products: [...currentState.products, ...products.items],
            hasNextPage: products.hasNextPage,
            currentPage: products.page,
          ),
        );
      },
    );
  }
}
