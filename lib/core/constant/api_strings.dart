abstract final class ApiKeys {
  static const baseUrl = 'https://accessories-eshop.runasp.net';
  static const authLogin = '/api/auth/login';
  static const authRegister = '/api/auth/register';
  static const authVerifyEmail = '/api/auth/verify-email';
  static const products = '/api/products';

  static String productById(String id) => '$products/$id';

  static const page = 'page';
  static const pageSize = 'pageSize';
  static const items = 'items';
  static const totalCount = 'totalCount';
  static const hasNextPage = 'hasNextPage';
  static const hasPreviousPage = 'hasPreviousPage';

  static const id = 'id';
  static const name = 'name';
  static const description = 'description';
  static const nameArabic = 'nameArabic';
  static const descriptionArabic = 'descriptionArabic';
  static const coverPictureUrl = 'coverPictureUrl';
  static const productPictures = 'productPictures';
  static const productCode = 'productCode';
  static const categories = 'categories';
  static const price = 'price';
  static const stock = 'stock';
  static const weight = 'weight';
  static const color = 'color';
  static const sellerId = 'sellerId';
  static const rating = 'rating';
  static const reviewsCount = 'reviewsCount';
  static const discountPercentage = 'discountPercentage';

  static const email = 'email';
  static const otp = 'otp';
  static const password = 'password';
  static const firstName = 'firstName';
  static const lastName = 'lastName';

  static const accessToken = 'accessToken';
  static const expiresAtUtc = 'expiresAtUtc';
  static const refreshToken = 'refreshToken';
}
