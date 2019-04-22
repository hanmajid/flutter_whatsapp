import 'package:flutter/material.dart';

class TextHelpers {
  static RichText getHighlightedText(
      String text, String keyword, TextStyle normalStyle, TextStyle highlightStyle) {

    int index = text.toLowerCase().indexOf(keyword.toLowerCase());

    List<TextSpan> texts = new List<TextSpan>();
    if (index > 0) {
      texts.add(TextSpan(
        text: text.substring(0, index),
        style: normalStyle,
      ));
    }
    texts.add(TextSpan(
      text: text.substring(index, index + keyword.length),
      style: highlightStyle,
    ));
    if (index + keyword.length < text.length) {
      texts.add(TextSpan(
        text: text.substring(index + keyword.length),
        style: normalStyle,
      ));
    }

    return RichText(
      text: TextSpan(
        children: texts,
      ),
    );
  }
}