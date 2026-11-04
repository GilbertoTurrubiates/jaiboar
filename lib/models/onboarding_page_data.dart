import 'package:flutter/material.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.title,
    required this.description,
    required this.icon,
    required this.primaryColor,
    required this.backgroundColor,
    required this.semanticLabel,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color primaryColor;
  final Color backgroundColor;
  final String semanticLabel;
}