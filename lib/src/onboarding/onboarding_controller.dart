import 'package:flutter/material.dart';

class OnboardingController {
  OnboardingController({
    void Function(int index)? onPageChanged,
  }) : pageChanged = onPageChanged;

  void goToPage(int index) {}
  void next() {}
  void previous() {}

  void Function(int index)? pageChanged;
}

class OnboardingPage {
  const OnboardingPage({required this.child});
  final Widget child;
}
