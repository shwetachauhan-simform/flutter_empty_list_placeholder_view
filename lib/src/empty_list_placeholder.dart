import 'package:empty_placeholder_view/src/empry_placeholder_refresh_button.dart';
import 'package:empty_placeholder_view/src/spin_kit_loader.dart';
import 'package:empty_placeholder_view/src/values/constants.dart';
import 'package:empty_placeholder_view/src/values/enums.dart';
import 'package:empty_placeholder_view/src/values/strings.dart';
import 'package:empty_placeholder_view/src/vector_asset.dart';
import 'package:flutter/material.dart';

import 'extensions.dart';

class EmptyListPlaceholder extends StatelessWidget {
  final ApiState? state;
  final VoidCallback? onButtonClick;
  final String? placeholderImage;
  final String? darkPlaceholderImage;
  final String? svgPlaceholder;
  final String? svgDarkPlaceholder;
  final EdgeInsets? extraPadding;
  final String? buttonText;
  final double? buttonWidth;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final bool hideButton;
  final String? loadingTitle;
  final String? loadingSubtitle;
  final String? errorTitle;
  final String? errorSubtitle;
  final String? emptyTitle;
  final String? emptySubtitle;
  final LoaderName? loadingWidgetName;
  final Widget? loadingWidget;
  final Color? loadingColor;
  final double? titleFontSize;
  final double? subTitleFontSize;
  final String? titleFontFamily;
  final String? subTitleFontFamily;

  const EmptyListPlaceholder({
    Key? key,
    @required this.state,
    this.onButtonClick,
    this.placeholderImage,
    this.darkPlaceholderImage,
    this.svgPlaceholder,
    this.svgDarkPlaceholder,
    this.extraPadding,
    this.buttonText,
    this.buttonWidth,
    this.buttonColor,
    this.buttonTextColor,
    this.hideButton = false,
    this.loadingTitle,
    this.loadingSubtitle,
    this.errorTitle,
    this.errorSubtitle,
    this.emptyTitle,
    this.emptySubtitle,
    this.loadingWidgetName,
    this.loadingWidget,
    this.loadingColor,
    this.titleFontSize,
    this.subTitleFontSize,
    this.titleFontFamily,
    this.subTitleFontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? title;
    String? subtitle;

    switch (state) {
      case ApiState.loading:
        {
          title = loadingTitle ?? AppStrings.holdOn;
          subtitle = loadingSubtitle ?? AppStrings.defaultLoadingSubtitle;
        }
        break;

      case ApiState.success:
        {
          title = emptyTitle ?? AppStrings.unavailable;
          subtitle = emptySubtitle;
        }
        break;

      case ApiState.error:
        {
          title = errorTitle ?? AppStrings.oops;
          subtitle = errorSubtitle ?? AppStrings.somethingWentWrong;
        }
        break;

      // ApiState.idle
      default:
        {
          title = '';
          subtitle = '';
        }
        break;
    }
    return SizedBox.expand(
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (svgPlaceholder?.isNotEmpty ?? false)
              Flexible(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: extraPadding ?? const EdgeInsets.all(0),
                    child: VectorAsset(
                      image: context.isDarkTheme
                          ? darkPlaceholderImage ?? placeholderImage
                          : placeholderImage,
                      svg: context.isDarkTheme
                          ? svgDarkPlaceholder ?? svgPlaceholder
                          : svgPlaceholder,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            if (title != null)
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleFontSize ?? 20,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.bold,
                  fontFamily:
                      titleFontFamily ?? AppConstants.appFontCircularStd,
                ),
              ),
            if (title != null && subtitle != null) const SizedBox(height: 5),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: subTitleFontSize ?? 14,
                    letterSpacing: 0.4,
                    fontFamily:
                        subTitleFontFamily ?? AppConstants.appFontCircularStd,
                  ),
                ),
              ),
            const SizedBox(height: 24),
            Visibility(
              visible: state != ApiState.loading && !hideButton,
              child: EmptyPlaceholderRefreshButton(
                onTap: onButtonClick ?? () {},
                height: 46,
                width: buttonWidth ?? 120,
                color: buttonColor,
                textColor: buttonTextColor,
                title: buttonText ??
                    (state == ApiState.success
                        ? AppStrings.refresh
                        : AppStrings.retry),
              ),
            ),
            Visibility(
              visible: state == ApiState.loading,
              child: Container(
                alignment: Alignment.center,
                height: 56,
                child: (loadingWidget != null)
                    ? loadingWidget
                    : SpinKitLoader(
                        loaderName: loadingWidgetName,
                        color: loadingColor,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
