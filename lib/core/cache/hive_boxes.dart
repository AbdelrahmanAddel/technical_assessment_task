import 'package:hive_flutter/hive_flutter.dart';

import '../constant/storage_keys.dart';

abstract final class HiveBoxes {
  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isBoxOpen(StorageKeys.productsBox)) {
      await Hive.openBox(StorageKeys.productsBox);
    }

    if (!Hive.isBoxOpen(StorageKeys.productDetailsBox)) {
      await Hive.openBox(StorageKeys.productDetailsBox);
    }
  }

  static Box get products => Hive.box(StorageKeys.productsBox);

  static Box get productDetails => Hive.box(StorageKeys.productDetailsBox);
}
