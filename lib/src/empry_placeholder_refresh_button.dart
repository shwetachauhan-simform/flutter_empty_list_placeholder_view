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
  final Color? textColor;
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
    this.textColor,
    this.enableFeedback = true,
    this.shape,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 64,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: shape,
          padding: padding,
          enableFeedback: !loading && enableFeedback,
          primary: color,
        ),
        onPressed: enabled && !loading ? onTap : null,
        child: loading
            ? SizedBox.fromSize(
                size: Size.square((height ?? 64) - 24),
                child: SpinKitThreeBounce(
                  color: Theme.of(context).textTheme.button!.color,
                  size: (height ?? 64) * 0.32,
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
                          fontSize: fontSize ?? 18,
                          height: icon != null ? 1.2 : 1,
                          color: textColor ?? Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
