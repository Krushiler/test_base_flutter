import 'package:flutter/material.dart';
import 'package:test_base_flutter/ui/dimens.dart';
import 'package:test_base_flutter/ui/kit/gap.dart';
import 'package:test_base_flutter/ui/theme/app_text_theme.dart';

class TermListItem extends StatelessWidget {
  final String name;
  final String translation;
  final String description;
  final VoidCallback? onPressed;

  const TermListItem({
    required this.name,
    required this.translation,
    required this.description,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$name - $translation',
              style: Theme.of(context).textTheme.h3,
            ),
            Gap.sm,
            Text(
              description,
              style: Theme.of(context).textTheme.p2,
            )
          ],
        ),
      ),
    );
  }
}
