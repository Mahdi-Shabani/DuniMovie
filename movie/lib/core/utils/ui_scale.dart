import 'package:flutter/material.dart';

// Design size: iPhone 12 = 390 × 844
const _kDesignW = 390.0;
const _kDesignH = 844.0;

// scale by width
double sw(BuildContext context, double v) =>
    v * MediaQuery.of(context).size.width / _kDesignW;

// scale by height
double sh(BuildContext context, double v) =>
    v * MediaQuery.of(context).size.height / _kDesignH;

// scale for font (use width as base)
double sp(BuildContext context, double v) => sw(context, v);
