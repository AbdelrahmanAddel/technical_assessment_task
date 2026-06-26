import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_techincal_test/core/api/result.dart';
import 'package:flutter_techincal_test/core/errors/failures.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/products.dart';
import 'package:flutter_techincal_test/features/home/domain/usecases/get_products_use_case.dart';
import 'package:flutter_techincal_test/features/home/presentation/cubit/products_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/cubit/products_state.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/home_test_fixtures.dart';
import '../../helpers/mock_products_repository.dart';
import '../../helpers/products_state_matchers.dart';

void main() {
  late MockProductsRepository mockProductsRepository;

  ProductsCubit createCubit() {
    return ProductsCubit(
      getProductsUseCase: GetProductsUseCase(
        productsRepository: mockProductsRepository,
      ),
    );
  }

  void stubGetProducts({
    required int page,
    required Result<Products> result,
  }) {
    when(
      () => mockProductsRepository.getProducts(
        page: page,
        pageSize: HomeDimension.pageSize,
      ),
    ).thenAnswer((_) async => result);
  }

  setUp(() {
    mockProductsRepository = MockProductsRepository();
  });

  group('ProductsCubit', () {
    group('loadProducts', () {
      blocTest<ProductsCubit, ProductsState>(
        'should emit [ProductsLoading, ProductsSuccess] when fetch succeeds',
        build: () {
          stubGetProducts(page: HomeDimension.initialPage, result: const Success(tProducts));
          return createCubit();
        },
        act: (cubit) => cubit.loadProducts(),
        expect: () => [
          const ProductsLoading(),
          isProductsSuccess(
            products: tProducts.items,
            hasNextPage: tProducts.hasNextPage,
            currentPage: tProducts.page,
          ),
        ],
        verify: (_) {
          verify(
            () => mockProductsRepository.getProducts(
              page: HomeDimension.initialPage,
              pageSize: HomeDimension.pageSize,
            ),
          ).called(1);
        },
      );

      blocTest<ProductsCubit, ProductsState>(
        'should emit [ProductsLoading, ProductsFailure] when fetch fails',
        build: () {
          stubGetProducts(
            page: HomeDimension.initialPage,
            result: const FailureResult(
              ServerFailure(errMessage: tFailureMessage),
            ),
          );
          return createCubit();
        },
        act: (cubit) => cubit.loadProducts(),
        expect: () => [
          const ProductsLoading(),
          isA<ProductsFailure>().having(
            (state) => state.message,
            'message',
            tFailureMessage,
          ),
        ],
      );
    });

    group('refreshProducts', () {
      blocTest<ProductsCubit, ProductsState>(
        'should emit [ProductsSuccess(isRefreshing), ProductsSuccess] when products are already loaded',
        build: () {
          stubGetProducts(page: HomeDimension.initialPage, result: const Success(tProducts));
          return createCubit()
            ..emit(
              ProductsSuccess(
                products: const [tProductTwo],
                hasNextPage: false,
                currentPage: 1,
              ),
            );
        },
        act: (cubit) => cubit.refreshProducts(),
        expect: () => [
          isProductsSuccess(
            products: const [tProductTwo],
            hasNextPage: false,
            currentPage: 1,
            isRefreshing: true,
          ),
          isProductsSuccess(
            products: tProducts.items,
            hasNextPage: tProducts.hasNextPage,
            currentPage: tProducts.page,
          ),
        ],
      );

      blocTest<ProductsCubit, ProductsState>(
        'should keep current products when refresh fails',
        build: () {
          stubGetProducts(
            page: HomeDimension.initialPage,
            result: const FailureResult(
              ServerFailure(errMessage: tFailureMessage),
            ),
          );
          return createCubit()
            ..emit(
              const ProductsSuccess(
                products: [tProductTwo],
                hasNextPage: false,
                currentPage: 1,
              ),
            );
        },
        act: (cubit) => cubit.refreshProducts(),
        expect: () => [
          isProductsSuccess(
            products: const [tProductTwo],
            hasNextPage: false,
            currentPage: 1,
            isRefreshing: true,
          ),
          isProductsSuccess(
            products: const [tProductTwo],
            hasNextPage: false,
            currentPage: 1,
          ),
        ],
      );

      blocTest<ProductsCubit, ProductsState>(
        'should emit [ProductsLoading, ProductsSuccess] when products are not loaded',
        build: () {
          stubGetProducts(page: HomeDimension.initialPage, result: const Success(tProducts));
          return createCubit();
        },
        act: (cubit) => cubit.refreshProducts(),
        expect: () => [
          const ProductsLoading(),
          isProductsSuccess(
            products: tProducts.items,
            hasNextPage: tProducts.hasNextPage,
            currentPage: tProducts.page,
          ),
        ],
      );
    });

    group('loadMoreProducts', () {
      blocTest<ProductsCubit, ProductsState>(
        'should emit [ProductsSuccess(isLoadingMore), ProductsSuccess] when next page fetch succeeds',
        build: () {
          stubGetProducts(page: 2, result: const Success(tProductsPageTwo));
          return createCubit()
            ..emit(
              const ProductsSuccess(
                products: [tProduct],
                hasNextPage: true,
                currentPage: 1,
              ),
            );
        },
        act: (cubit) => cubit.loadMoreProducts(),
        expect: () => [
          isProductsSuccess(
            products: const [tProduct],
            hasNextPage: true,
            currentPage: 1,
            isLoadingMore: true,
          ),
          isProductsSuccess(
            products: const [tProduct, tProductTwo],
            hasNextPage: false,
            currentPage: 2,
          ),
        ],
        verify: (_) {
          verify(
            () => mockProductsRepository.getProducts(
              page: 2,
              pageSize: HomeDimension.pageSize,
            ),
          ).called(1);
        },
      );

      blocTest<ProductsCubit, ProductsState>(
        'should reset isLoadingMore when next page fetch fails',
        build: () {
          stubGetProducts(
            page: 2,
            result: const FailureResult(
              ServerFailure(errMessage: tFailureMessage),
            ),
          );
          return createCubit()
            ..emit(
              const ProductsSuccess(
                products: [tProduct],
                hasNextPage: true,
                currentPage: 1,
              ),
            );
        },
        act: (cubit) => cubit.loadMoreProducts(),
        expect: () => [
          isProductsSuccess(
            products: const [tProduct],
            hasNextPage: true,
            currentPage: 1,
            isLoadingMore: true,
          ),
          isProductsSuccess(
            products: const [tProduct],
            hasNextPage: true,
            currentPage: 1,
          ),
        ],
      );

      blocTest<ProductsCubit, ProductsState>(
        'should not emit new states when there is no next page',
        build: createCubit,
        seed: () => const ProductsSuccess(
          products: [tProduct],
          hasNextPage: false,
          currentPage: 1,
        ),
        act: (cubit) => cubit.loadMoreProducts(),
        expect: () => <ProductsState>[],
        verify: (_) {
          verifyNever(
            () => mockProductsRepository.getProducts(
              page: any(named: 'page'),
              pageSize: any(named: 'pageSize'),
            ),
          );
        },
      );

      blocTest<ProductsCubit, ProductsState>(
        'should not emit new states when products are not loaded',
        build: createCubit,
        act: (cubit) => cubit.loadMoreProducts(),
        expect: () => <ProductsState>[],
        verify: (_) {
          verifyNever(
            () => mockProductsRepository.getProducts(
              page: any(named: 'page'),
              pageSize: any(named: 'pageSize'),
            ),
          );
        },
      );
    });
  });
}
