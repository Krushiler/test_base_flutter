import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_base_flutter/ui/dimens.dart';

class SvgButton extends StatelessWidget {
  final String asset;
  final VoidCallback? onPressed;

  const SvgButton({
    Key? key,
    required this.asset,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: const BoxConstraints(),
      padding: EdgeInsets.zero,
      splashRadius: Dimens.md,
      onPressed: onPressed,
      icon: SvgPicture.asset(asset),
    );
  }
}
