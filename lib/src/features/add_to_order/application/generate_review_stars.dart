import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';

List<Widget> generateReviewStars(double rating) {
  List<Widget> stars = [];
  for (int i = 1; i <= 5; i++) {
    if (rating >= i) {
      stars.add(const SFIcon(SFIcons.sf_star_fill,
          color: Colors.white, fontSize: 12));
    } else if (rating >= i - 0.5) {
      stars.add(const SFIcon(SFIcons.sf_star_leadinghalf_filled,
          color: Colors.white, fontSize: 12));
    } else {
      stars.add(
          const SFIcon(SFIcons.sf_star, color: Colors.white, fontSize: 12));
    }
  }
  return stars;
}
