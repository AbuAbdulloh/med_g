import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class WButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Color color;
  final Color textColor;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final GestureTapCallback onTap;
  final Widget? child;
  final BoxBorder? border;
  final bool loading;
  final bool disabled;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;
  const WButton({
    required this.onTap,
    this.width,
    this.borderRadius,
    this.height,
    this.text = '',
    this.textStyle,
    this.margin,
    this.padding,
    this.border,
    this.child,
    this.boxShadow,
    this.color = const Color(0xff0062FF),
    this.textColor = AppTheme.white,
    this.loading = false,
    this.disabled = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => WScaleAnimation(
        onTap: (value) {
          if (!(loading || disabled)) {
            onTap();
          }
        },
        isDisabled: disabled,
        child: Container(
          width: width,
          height: height,
          margin: margin,
          padding: padding ?? const EdgeInsets.all(14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: disabled ? AppTheme.neutral : color,
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            border: border,
            boxShadow: boxShadow ??
                [
                  BoxShadow(
                    color: AppTheme.black.withOpacity(0.1),
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: const Offset(1, 1),
                  ),
                ],
          ),
          child: loading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : child ??
                  Text(
                    text.tr(),
                    style: textStyle ??
                        Theme.of(context).textTheme.headline3!.copyWith(
                              color: textColor,
                              fontSize: 16,
                            ),
                  ),
        ),
      );
}
