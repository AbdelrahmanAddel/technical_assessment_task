import '../../../../core/constant/api_strings.dart';

abstract final class StorageKeys {
  static const accessToken = ApiKeys.accessToken;
  static const refreshToken = ApiKeys.refreshToken;

  static const productsBox = 'products_box';
  static const productDetailsBox = 'product_details_box';

  static const themeMode = 'theme_mode';
  static const userId = 'user_id';
  static const userName = 'user_name';
  static const userEmail = 'user_email';
  static const userProfilePicture = 'user_profile_picture';

  static String productsPageKey(int page) => 'page_$page';
}
