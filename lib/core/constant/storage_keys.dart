import '../../../../core/constant/api_strings.dart';

abstract final class StorageKeys {
  static const accessToken = ApiKeys.accessToken;
  static const refreshToken = ApiKeys.refreshToken;

  static const productsBox = 'products_box';
  static const productDetailsBox = 'product_details_box';

  static String productsPageKey(int page) => 'page_$page';
}
