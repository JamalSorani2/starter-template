import 'package:flutter/material.dart';

extension TextDirectionExtension on String? {
  TextDirection get textDirection {
    if (this == null || this!.isEmpty) {
      return TextDirection.rtl;
    }
    final char = this![0];
    if (!RegExp(r'[\u0600-\u06FF]').hasMatch(char)) {
      return TextDirection.ltr;
    } else {
      return TextDirection.rtl;
    }
  }
}
