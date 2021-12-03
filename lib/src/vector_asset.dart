import 'package:empty_placeholder_view/src/values/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'extensions.dart';

/// This widget allows to use svg vectors when running on web
class VectorAsset extends StatelessWidget {
  final String? image;
  final String? svg;
  final Color? color;
  final BlendMode? colorBlendMode;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment alignment;
  final String? dark;

  const VectorAsset({
    this.image,
    this.svg,
    Key? key,
    this.color,
    this.colorBlendMode,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.dark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (image != null)
        ? kIsWeb
            ? Image.network(
                AppConstants.webAssetPrefix +
                    (context.isDarkTheme ? dark ?? image! : image!),
                color: color,
                colorBlendMode: colorBlendMode,
                width: width,
                height: height,
                fit: fit,
                alignment: alignment,
              )
            : Image.asset(
                image!,
                width: width,
                height: height,
                fit: fit ?? BoxFit.contain,
                alignment: alignment,
              )
        : (svg != null)
            ? SvgPicture.asset(
                context.isDarkTheme ? dark ?? svg! : svg!,
                color: color,
                colorBlendMode: colorBlendMode ?? BlendMode.srcIn,
                width: width,
                height: height,
                fit: fit ?? BoxFit.contain,
                alignment: alignment,
              )
            : Image.asset('');
  }
}
