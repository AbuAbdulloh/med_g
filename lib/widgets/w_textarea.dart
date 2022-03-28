import 'package:flutter/material.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/app/theme/theme.dart';

class WTextArea extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool borderGreen;
  final bool borderGrey;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final TextStyle? style;
  const WTextArea({
    Key? key,
    this.hintText,
    this.controller,
    this.borderGreen = false,
    this.borderGrey = false,
    this.onChanged,
    this.maxLength,
    this.style,
  }) : super(key: key);

  @override
  _WTextAreaState createState() => _WTextAreaState();
}

class _WTextAreaState extends State<WTextArea> {
  OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: color, width: 1));

  @override
  Widget build(BuildContext context) => TextField(
        style: widget.style,
        maxLength: widget.maxLength,
        controller: widget.controller,
        onChanged: widget.onChanged,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.all(12),
          hintStyle: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
          enabledBorder: border(widget.borderGrey ? grey : dark),
          fillColor: white,
          filled: true,
          border: border(grey),
          disabledBorder: border(grey),
          focusedBorder: border(primary),
        ),
      );
}
