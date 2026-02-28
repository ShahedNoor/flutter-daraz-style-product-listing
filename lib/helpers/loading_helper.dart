import 'package:flutter/material.dart';
import '../common_widgets/loading_indicators.dart';
import 'navigation_service.dart';

extension Loader<T> on Future<T> {
  Future<T> waitingForFutureWithoutBg() async {
    showDialog(
      context: NavigationService.context,
      builder: (context) => const CustomLoader(),
    );

    try {
      // Wait for the original future to complete
      T result = await this;
      return result;
    } finally {
      // Close the loading dialog
      NavigationService.goBack;
    }
  }
}
