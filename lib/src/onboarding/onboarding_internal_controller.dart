import 'dart:async';

import 'package:flutter/material.dart';
import 'onboarding_controller.dart';

class OnboardingInternalController {
  OnboardingInternalController({
    required List<OnboardingPage> pages,
    OnboardingController? controller,
    bool? autoplay,
    Duration? duration,
    int initialPage = 0,
    bool isScrollable = true,
  })  : _pages = pages,
        _controller = controller,
        _autoplay = autoplay ?? true,
        _duration = duration ?? const Duration(seconds: 3),
        _pageController = PageController(
          initialPage: initialPage,
          keepPage: true,
        ),
        _physics = isScrollable
            ? const PageScrollPhysics()
            : const NeverScrollableScrollPhysics();

  final PageController _pageController;
  final ScrollPhysics _physics;
  final List<OnboardingPage> _pages;
  final OnboardingController? _controller;
  final bool _autoplay;
  final Duration _duration;

  Timer? _timer;

  PageController get pageController => _pageController;
  ScrollPhysics get physics => _physics;
  List<OnboardingPage> get pages => _pages;

  int _currentPage = 0;
  int get currentPage => _currentPage;

  void onPageChanged(int index) {
    _currentPage = index;
    _controller?.pageChanged?.call(index);
    stopTimer();
    _initializeTimer();
  }

  void initialize() {
    if (!_autoplay) {
      return;
    }
    _initializeTimer();
  }

  void _initializeTimer() {
    _timer ??= Timer.periodic(
      _duration,
      (timer) {
        int nextPage = (_currentPage + 1) < pages.length ? _currentPage + 1 : 0;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
