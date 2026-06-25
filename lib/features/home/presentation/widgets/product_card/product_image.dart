import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/theme/app_colors.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/product_hero.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.productId,
    required this.coverPictureUrl,
  });

  final String productId;
  final String coverPictureUrl;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(HomeDimension.productCardBorderRadius),
      ),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: coverPictureUrl.isEmpty
            ? _ImagePlaceholder(colors: colors, icon: Icons.image_outlined)
            : Hero(
                tag: ProductHero.imageTag(productId),
                child: CachedNetworkImage(
                  imageUrl: coverPictureUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (_, _) => ColoredBox(
                    color: colors.border,
                    child: Center(
                      child: SizedBox.square(
                        dimension: HomeDimension.loadMoreIndicatorSize,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colors.primary,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (_, _, _) => _ImagePlaceholder(
                    colors: colors,
                    icon: Icons.broken_image_outlined,
                  ),
                ),
              ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.colors, required this.icon});

  final AppColors colors;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: colors.border,
      child: Icon(
        icon,
        color: colors.text.withValues(
          alpha: HomeDimension.productImagePlaceholderIconAlpha,
        ),
      ),
    );
  }
}
