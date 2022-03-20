import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class WTextField extends StatefulWidget {
  final bool borderGreen;
  final bool? hasBorderColor;
  final bool? hasClearButton;
  final String title;
  final double borderRadius;
  final TextStyle? titleTextStyle;
  final TextStyle? textStyle;
  final String? hintText;
  final TextStyle? prefixStyle;
  final TextStyle? hintTextStyle;
  final String prefixText;
  final bool? hideCounterText;
  final Widget? prefix;
  final EdgeInsets? prefixPadding;
  final double? width;
  final double? height;
  final int? maxLength;
  final TextInputType? keyBoardType;
  final bool isObscureText;
  final Widget? suffix;
  final String? suffixIcon;
  final EdgeInsets? suffixPadding;
  final TextCapitalization textCapitalization;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final List<TextInputFormatter>? textInputFormatters;
  final EdgeInsets? contentPadding;
  final bool hasError;
  final double sizeBetweenFieldTitle;
  final Color? errorColor;
  final Color? fillColor;
  final EdgeInsets? margin;
  final VoidCallback? onEyeTap;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextInputAction textInputAction;
  final Function? onObscure;

  final Function? onTapSuffix;
  final Function()? onEditCompleted;
  final int? maxlines;

  const WTextField({
    required this.controller,
    this.hasBorderColor,
    required this.onChanged,
    this.hideCounterText,
    this.borderRadius = 4,
    this.maxlines = 1,
    this.prefixStyle,
    this.hasClearButton,
    this.textAlign = TextAlign.start,
    this.width,
    this.fillColor,
    this.title = '',
    this.titleTextStyle,
    this.textStyle,
    this.hintText,
    this.hintTextStyle,
    this.contentPadding = const EdgeInsets.all(12),
    this.prefixText = '',
    this.prefix,
    this.prefixPadding = const EdgeInsets.all(12),
    this.suffix,
    this.suffixIcon,
    this.suffixPadding = const EdgeInsets.all(12),
    this.isObscureText = false,
    this.onEyeTap,
    this.margin,
    this.sizeBetweenFieldTitle = 8,
    this.errorColor,
    this.hasError = false,
    this.textInputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.keyBoardType,
    this.maxLength,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.height,
    this.onObscure,
    this.onTapSuffix,
    Key? key,
    this.onEditCompleted,
    this.borderGreen = false,
  }) : super(key: key);

  @override
  _WTextFieldState createState() => _WTextFieldState();
}

class _WTextFieldState extends State<WTextField> {
  late FocusNode focusNode;
  bool focused = false;
  bool hasText = false;
  bool isObscure = true;
  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();

    focusNode.addListener(
      () => setState(() => focused = !focused),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title.isNotEmpty)
            Text(
              widget.title.tr(),
              style: widget.titleTextStyle ??
                  Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 14,
                      ),
            )
          else
            const SizedBox(),
          SizedBox(
            height:
                widget.title.isNotEmpty ? widget.sizeBetweenFieldTitle : null,
          ),
          Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: TextField(
                    textAlign: widget.textAlign,
                    inputFormatters: widget.textInputFormatters,
                    textInputAction: widget.textInputAction,
                    textCapitalization: widget.textCapitalization,
                    obscureText: widget.isObscureText ? isObscure : false,
                    keyboardType: widget.keyBoardType,
                    maxLength: widget.maxLength,
                    controller: widget.controller,
                    maxLines: widget.maxlines,
                    autofocus: false,
                    cursorColor: Theme.of(context).colorScheme.secondaryVariant,
                    cursorHeight: 20,
                    onEditingComplete: widget.onEditCompleted,
                    onChanged: (s) {
                      setState(() => hasText = s.isNotEmpty);
                      widget.onChanged(s);
                    },
                    focusNode: focusNode,
                    style: widget.textStyle ??
                        Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(
                          width: 1,
                          color: widget.hasError
                              ? Theme.of(context).colorScheme.error
                              : background,
                        ),
                      ),
                      counterText: widget.hideCounterText != null &&
                              widget.hideCounterText!
                          ? ''
                          : null,
                      hintText: widget.hintText,
                      hintStyle: widget.hintTextStyle ??
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 16,
                              ),
                      filled: true,
                      prefixIcon: widget.prefix,
                      fillColor: widget.fillColor,
                      contentPadding: widget.contentPadding,
                      disabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(
                          width: 1,
                          color: widget.hasBorderColor != null &&
                                  !widget.hasBorderColor!
                              ? Colors.transparent
                              : widget.hasError
                                  ? Theme.of(context).colorScheme.error
                                  : background,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(
                          width: 1,
                          color: widget.hasBorderColor != null &&
                                  !widget.hasBorderColor!
                              ? Colors.transparent
                              : widget.hasError
                                  ? Theme.of(context).colorScheme.error
                                  : background,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(
                          width: 1,
                          color: widget.hasBorderColor != null &&
                                  !widget.hasBorderColor!
                              ? Colors.transparent
                              : widget.hasError
                                  ? Theme.of(context).colorScheme.error
                                  : primary,
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.prefixText.isNotEmpty)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Text(
                        widget.prefixText,
                        style: widget.prefixStyle ??
                            Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 16),
                      ),
                    ),
                  )
                else
                  const SizedBox(),
                Positioned(
                  right: 12,
                  child: widget.hasClearButton != null && widget.hasClearButton!
                      ? widget.controller.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                setState(() {});
                                widget.controller.clear();
                              },
                              child: SvgPicture.asset(AppIcons.closeGreen),
                            )
                          : const SizedBox()
                      : widget.suffix ?? const SizedBox(),
                ),
                Positioned(
                  top: 6,
                  right: 8,
                  child: !widget.isObscureText
                      ? widget.suffixIcon != null
                          ? WScaleAnimation(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 6, 2, 6),
                                child: SvgPicture.asset(
                                  widget.suffixIcon!,
                                ),
                              ),
                            )
                          : const SizedBox()
                      : WScaleAnimation(
                          onTap: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 6, 2, 6),
                            child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 650),
                                child: isObscure == true
                                    ? SvgPicture.asset(AppIcons.eyeOn)
                                    : SvgPicture.asset(AppIcons.eyeOff)),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
