import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_base_flutter/ui/dimens.dart';
import 'package:test_base_flutter/ui/theme/app_text_theme.dart';

class DictionaryListItem extends StatelessWidget {
  final String name;
  final VoidCallback? onPressed;

  const DictionaryListItem({required this.name, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.md),
        child: Row(
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.p2,
            ),
            const Spacer(),
            SvgPicture.asset('assets/icons/arrow_list_choose.svg')
          ],
        ),
      ),
    );
  }
}
