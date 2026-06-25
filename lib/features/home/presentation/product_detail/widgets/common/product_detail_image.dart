import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/product_hero.dart';

class ProductDetailImage extends StatelessWidget {
  const ProductDetailImage({
    super.key,
    required this.productId,
    required this.coverPictureUrl,
  });

  final String productId;
  final String coverPictureUrl;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    if (coverPictureUrl.isEmpty) {
      return ColoredBox(
        color: colors.border,
        child: Icon(
          Icons.image_outlined,
          size: 64,
          color: colors.text.withValues(
            alpha: HomeDimension.productImagePlaceholderIconAlpha,
          ),
        ),
      );
    }

    return Hero(
      tag: ProductHero.imageTag(productId),
      child: CachedNetworkImage(
        imageUrl: coverPictureUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        placeholder: (_, _) => ColoredBox(
          color: colors.border,
          child: Center(
            child: CircularProgressIndicator(color: colors.primary),
          ),
        ),
        errorWidget: (_, _, _) => ColoredBox(
          color: colors.border,
          child: Icon(Icons.broken_image_outlined, color: colors.text),
        ),
      ),
    );
  }
}
