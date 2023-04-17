import 'package:flutter/material.dart';
import 'package:test_base_flutter/data/model/dictionary/tag.dart';

class TagSwitcher extends StatelessWidget {
  final Tag value;
  final List<Tag> values;
  final ValueChanged<Tag> onTagSwitched;

  const TagSwitcher({
    Key? key,
    required this.value,
    required this.onTagSwitched,
    required this.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = (values.indexOf(value) + 1) % values.length;
    final newValue = values[index];
    return TextButton(
      onPressed: () {
        onTagSwitched.call(newValue);
      },
      child: Text(value.name),
    );
  }
}
