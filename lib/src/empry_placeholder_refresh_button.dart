import 'package:empty_placeholder_view/src/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EmptyPlaceholderRefreshButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool enabled;
  final String? title;
  final double? width;
  final double? height;
  final double? fontSize;
  final bool loading;
  final bool enableFeedback;
  final Widget? child;
  final EdgeInsets? padding;
  final Color? color;
  final OutlinedBorder? shape;
  final Widget? icon;

  const EmptyPlaceholderRefreshButton({
    Key? key,
    required this.onTap,
    this.enabled = true,
    this.title,
    this.width = double.maxFinite,
    this.height,
    this.fontSize,
    this.loading = false,
    this.child,
    this.padding,
    this.color,
    this.enableFeedback = true,
    this.shape,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 64.sdp,
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              shape: shape != null ? MaterialStateProperty.all(shape) : null,
              padding:
                  padding != null ? MaterialStateProperty.all(padding) : null,
              enableFeedback: !loading && enableFeedback,
              backgroundColor:
                  color != null ? MaterialStateProperty.all(color) : null,
            ),
        onPressed: enabled && !loading ? onTap : null,
        child: loading
            ? SizedBox.fromSize(
                size: Size.square((height ?? 64.sdp) - 24.sdp),
                child: SpinKitThreeBounce(
                  color: Theme.of(context).textTheme.button!.color,
                  size: (height ?? 64.sdp) * 0.32,
                ),
              )
            : child ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (icon != null) ...{
                      icon!,
                      const SizedBox(width: 8),
                    },
                    Flexible(
                      child: Text(
                        title ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fontSize ?? 18.sdp,
                          height: icon != null ? 1.2 : 1,
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
