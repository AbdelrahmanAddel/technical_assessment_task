import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/profile_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/profile_avatar_placeholder.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: colors.primary.withValues(alpha: 0.25),
          width: ProfileDimension.avatarBorderWidth,
        ),
      ),
      child: ClipOval(
        child: SizedBox.square(
          dimension: ProfileDimension.avatarSize,
          child: imageUrl.isEmpty
              ? ProfileAvatarPlaceholder(colors: colors, name: name)
              : CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, _) => ProfileAvatarPlaceholder(
                    colors: colors,
                    name: name,
                    isLoading: true,
                  ),
                  errorWidget: (_, _, _) => ProfileAvatarPlaceholder(
                    colors: colors,
                    name: name,
                  ),
                ),
        ),
      ),
    );
  }
}
