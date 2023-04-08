import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_base_flutter/ui/dimens.dart';
import 'package:test_base_flutter/ui/theme/app_colors.dart';
import 'package:test_base_flutter/ui/theme/app_text_theme.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool autofocus;
  final TextInputType? keyboardType;
  final bool enabled;
  final bool showCursor;
  final FocusNode? focusNode;
  final bool obscureText;
  final String obscuringCharacter;
  final List<TextInputFormatter>? inputFormatters;
  final String? labelText;
  final String? errorText;
  final String? prefixText;

  const RoundedTextField(
      {super.key,
      this.controller,
      this.autofocus = false,
      this.enabled = true,
      this.keyboardType,
      this.showCursor = true,
      this.focusNode,
      this.obscureText = false,
      this.obscuringCharacter = '•',
      this.inputFormatters,
      this.labelText,
      this.errorText,
      this.prefixText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      keyboardType: keyboardType,
      enabled: enabled,
      showCursor: showCursor,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      style: Theme.of(context).textTheme.inputText,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        prefixText: prefixText,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.sm),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: Dimens.xs,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.sm),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: Dimens.xs,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.sm),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: Dimens.xs,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.sm),
          borderSide: const BorderSide(
            color: AppColors.brandPrimary,
            width: Dimens.xs,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.sm),
          borderSide: const BorderSide(
            color: AppColors.brandPrimary,
            width: Dimens.xs,
          ),
        ),
        filled: true,
        fillColor: AppColors.gray.shade100,
        floatingLabelStyle: Theme.of(context)
            .textTheme
            .inputLabel
            ?.copyWith(color: AppColors.gray.shade400),
        prefixStyle: Theme.of(context).textTheme.inputText,
      ),
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
    );
  }
}
