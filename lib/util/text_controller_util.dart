import 'dart:math';

import 'package:flutter/cupertino.dart';

extension TextControllerUtil on TextEditingController {
  void removeSelectedText() {
    if (!selection.isCollapsed) {
      final start = min(selection.baseOffset, selection.extentOffset);
      final end = max(selection.baseOffset, selection.extentOffset);

      text = text.substring(0, start) + text.substring(end);

      selection = TextSelection.fromPosition(TextPosition(offset: start));
    }
  }

  void insertText(String insertedText) {
    removeSelectedText();

    final newOffset = selection.baseOffset + insertedText.length;

    text = text.substring(0, selection.baseOffset) +
        insertedText +
        text.substring(selection.baseOffset);

    selection = TextSelection.fromPosition(TextPosition(offset: newOffset));
  }

  void backspaceAtSelection() {
    if (!selection.isCollapsed) {
      removeSelectedText();
    } else {

      if (selection.baseOffset <= 0) return;

      final offset = selection.baseOffset - 1;

      if (selection.baseOffset < text.length) {
        text = text.substring(0, selection.baseOffset - 1) +
            text.substring(selection.baseOffset);
      } else {
        text = text.substring(0, selection.baseOffset - 1);
      }

      selection = TextSelection.fromPosition(TextPosition(offset: offset));
    }
  }
}
