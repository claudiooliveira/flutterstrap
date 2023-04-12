import 'package:flutter/material.dart';
import 'package:flutterstrap/flutterstrap.dart';
import 'package:flutterstrap/src/onboarding/onboarding_internal_controller.dart';

enum OnboardingStepsStyle { style1, style2, style3 }

class Onboarding extends StatefulWidget {
  const Onboarding({
    Key? key,
    required this.pages,
    this.autoplay = true,
    this.duration = const Duration(seconds: 3),
    this.initialPage = 0,
    this.isScrollable = true,
    this.controller,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  final List<OnboardingPage> pages;
  final bool autoplay;
  final Duration duration;
  final int initialPage;
  final bool isScrollable;
  final OnboardingController? controller;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late OnboardingInternalController _controller;

  @override
  void initState() {
    super.initState();
    _controller = OnboardingInternalController(
      pages: widget.pages,
      initialPage: widget.initialPage,
      isScrollable: widget.isScrollable,
      autoplay: widget.autoplay,
      duration: widget.duration,
    );

    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller.pageController,
              physics: _controller.physics,
              itemCount: widget.pages.length,
              onPageChanged: (index) =>
                  setState(() => _controller.onPageChanged.call(index)),
              itemBuilder: (context, index) {
                return widget.pages[index].child;
              },
            ),
          ),
          const SizedBox(height: Spacing.x4),
          Row(
            children: indicators(
              context: context,
              maxWidth: constraints.maxWidth / widget.pages.length,
            ),
          ),
        ],
      );
    });
  }

  List<Widget> indicators({
    required BuildContext context,
    required double maxWidth,
  }) {
    final theme = FlutterstrapTheme.of(context);
    final List<Widget> indicators = [];
    widget.pages.asMap().forEach((index, value) {
      indicators.add(
        _OnboardingStepIndicator(
          width: maxWidth,
          isSelected: _controller.currentPage == index,
          activeColor: widget.activeColor ?? theme.primaryColor,
          inactiveColor:
              widget.inactiveColor ?? theme.primaryColor.withOpacity(0.4),
        ),
      );
    });
    return indicators;
  }
}

class _OnboardingStepIndicator extends StatelessWidget {
  const _OnboardingStepIndicator({
    Key? key,
    required this.width,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
  }) : super(key: key);

  final double width;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        width: double.infinity,
        height: 6,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : inactiveColor,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
