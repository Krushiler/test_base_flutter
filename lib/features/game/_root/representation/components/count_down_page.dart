import 'package:flutter/material.dart';
import 'package:test_base_flutter/ui/theme/app_text_theme.dart';

class CountDownPage extends StatelessWidget {
  final int number;

  const CountDownPage(
    this.number, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        number.toString(),
        style: Theme.of(context).textTheme.h2,
      ),
    );
  }
}
