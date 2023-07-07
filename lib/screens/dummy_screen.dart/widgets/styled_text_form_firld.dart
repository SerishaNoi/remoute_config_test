import 'package:flutter/material.dart';

class StyledTextFormField extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(dynamic) onChanged;
  final Color enebledBorderColor;
  final Color focusedBorderColor;
  final Color lableColor;
  final Color editedTextStyle;
  final String lable;
  final BuildContext providedContext;

  const StyledTextFormField({
    super.key,
    required this.textEditingController,
    required this.onChanged,
    required this.enebledBorderColor,
    required this.focusedBorderColor,
    required this.lableColor,
    required this.editedTextStyle,
    required this.lable,
    required this.providedContext,
  });

  @override
  State<StyledTextFormField> createState() => _StyledTextFormFieldState();
}

class _StyledTextFormFieldState extends State<StyledTextFormField> {
  @override
  Widget build(BuildContext providedContext) {
    return TextFormField(
      style: TextStyle(color: widget.editedTextStyle),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.enebledBorderColor,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(color: widget.focusedBorderColor, width: 2),
        ),
        labelText: widget.lable,
        labelStyle: TextStyle(color: widget.lableColor),
      ),
      controller: widget.textEditingController,
      keyboardType: TextInputType.number,
      onChanged: widget.onChanged,
    );
  }
}
