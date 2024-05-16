import 'package:flutter/material.dart';

const LinearGradient kGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Colors.blue,
    Colors.grey,
  ],
);

LinearGradient kLightGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Colors.blue.withOpacity(0.3),
    Colors.grey.withOpacity(0.3),
  ],
);
