import 'package:flutter/material.dart';
import 'package:test_base_flutter/ui/dimens.dart';

class SvgButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;

  const SvgButton({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: const BoxConstraints(),
      padding: EdgeInsets.zero,
      splashRadius: Dimens.md,
      onPressed: onPressed,
      icon: icon,
    );
  }
}
