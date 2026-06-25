abstract final class RoutesStrings {
  static const splash = '/';
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const otp = '/otp';
  static const productDetails = '/products';

  static String productDetail(String productId) => '$productDetails/$productId';
}
