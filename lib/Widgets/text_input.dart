import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outstock/utils/theme_colors.dart';

class TextFormInput extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final String? label;
  final bool? obscure;
  final IconData? icon;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLenght;
  final bool? enable;
  final TextInputType? keyboardType;

  const TextFormInput(
      {super.key,
      required this.controller,
      this.hint,
      this.label,
      this.obscure,
      this.validator,
      this.icon,
      this.padding,
      this.margin,
      this.onFieldSubmitted,
      this.inputFormatters,
      this.maxLenght,
      this.enable,
      this.keyboardType});

  @override
  State<TextFormInput> createState() => _TextFormInputState();
}

class _TextFormInputState extends State<TextFormInput> {
  bool isObscure = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isObscure = widget.obscure ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ??
          const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      child: TextFormField(
        enabled: widget.enable,
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        onFieldSubmitted: widget.onFieldSubmitted,
        maxLength: widget.maxLenght,
        inputFormatters: widget.inputFormatters,
        obscureText: isObscure,
        decoration: InputDecoration(
          filled: true,
          fillColor: MainTheme.white,
          contentPadding: const EdgeInsets.only(top: 16),
          prefixIcon: widget.icon == null ? null : Icon(widget.icon),
          hintText: widget.hint,
          label: widget.label == null ? null : Text(widget.label!),
          labelStyle: const TextStyle(height: 4),
          suffixIcon: widget.obscure == null
              ? null
              : IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () => setState(() => isObscure = !isObscure)),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
