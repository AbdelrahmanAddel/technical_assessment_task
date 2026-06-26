import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_techincal_test/core/api/result.dart';
import 'package:flutter_techincal_test/core/errors/failures.dart';
import 'package:flutter_techincal_test/features/home/domain/usecases/get_products_use_case.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/home_test_fixtures.dart';
import '../../helpers/mock_products_repository.dart';

void main() {
  late MockProductsRepository mockProductsRepository;
  late GetProductsUseCase useCase;

  setUp(() {
    mockProductsRepository = MockProductsRepository();
    useCase = GetProductsUseCase(productsRepository: mockProductsRepository);
  });

  group('GetProductsUseCase', () {
    test('should return products when repository succeeds', () async {
      when(
        () => mockProductsRepository.getProducts(
          page: HomeDimension.initialPage,
          pageSize: HomeDimension.pageSize,
        ),
      ).thenAnswer((_) async => const Success(tProducts));

      final result = await useCase(
        page: HomeDimension.initialPage,
        pageSize: HomeDimension.pageSize,
      );

      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull, tProducts);
      verify(
        () => mockProductsRepository.getProducts(
          page: HomeDimension.initialPage,
          pageSize: HomeDimension.pageSize,
        ),
      ).called(1);
    });

    test('should return failure when repository fails', () async {
      const failure = ServerFailure(errMessage: tFailureMessage);

      when(
        () => mockProductsRepository.getProducts(
          page: HomeDimension.initialPage,
          pageSize: HomeDimension.pageSize,
        ),
      ).thenAnswer((_) async => const FailureResult(failure));

      final result = await useCase(
        page: HomeDimension.initialPage,
        pageSize: HomeDimension.pageSize,
      );

      expect(result.isFailure, isTrue);
      expect(result.failureOrNull?.errMessage, tFailureMessage);
      verify(
        () => mockProductsRepository.getProducts(
          page: HomeDimension.initialPage,
          pageSize: HomeDimension.pageSize,
        ),
      ).called(1);
    });
  });
}
