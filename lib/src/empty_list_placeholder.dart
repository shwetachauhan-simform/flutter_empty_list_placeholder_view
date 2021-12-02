import 'package:empty_placeholder_view/src/empry_placeholder_refresh_button.dart';
import 'package:empty_placeholder_view/src/values/enums.dart';
import 'package:empty_placeholder_view/src/values/strings.dart';
import 'package:empty_placeholder_view/src/vector_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'extensions.dart';

class EmptyListPlaceholder extends StatelessWidget {
  final ApiState? state;
  final VoidCallback? onButtonClick;
  final String? svgPlaceholder;
  final String? darkSvgPlaceholder;
  final EdgeInsets? extraPadding;
  final String? buttonText;
  final double? buttonWidth;
  final Color? buttonColor;
  final bool hideButton;
  final String? loadingTitle;
  final String? loadingSubtitle;
  final String? errorTitle;
  final String? errorSubtitle;
  final String? emptyTitle;
  final String? emptySubtitle;
  final Widget? loadingWidget;

  const EmptyListPlaceholder({
    Key? key,
    @required this.state,
    this.onButtonClick,
    this.svgPlaceholder,
    this.darkSvgPlaceholder,
    this.extraPadding,
    this.buttonText,
    this.buttonWidth,
    this.buttonColor,
    this.hideButton = false,
    this.loadingTitle,
    this.loadingSubtitle,
    this.errorTitle,
    this.errorSubtitle,
    this.emptyTitle,
    this.emptySubtitle,
    this.loadingWidget,
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
        padding: EdgeInsets.all(40.sdp),
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
                      context.isDarkTheme
                          ? darkSvgPlaceholder ?? svgPlaceholder!
                          : svgPlaceholder!,
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
                  fontSize: 20.sdp,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (title != null && subtitle != null) SizedBox(height: 5.sdp),
            if (subtitle != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.sdp),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sdp,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            SizedBox(height: 24.sdp),
            Visibility(
              visible: state != ApiState.error && !hideButton,
              child: EmptyPlaceholderRefreshButton(
                onTap: onButtonClick ?? () {},
                height: 56.sdp,
                width: buttonWidth ?? 120.sdp,
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
                height: 56.sdp,
                child: loadingWidget ??
                    SpinKitCircle(
                      color: Theme.of(context).colorScheme.secondary,
                      size: 32.sdp,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
