import 'package:flutter/material.dart';

class CustomRatingWidget extends StatelessWidget {
  /// The current rating score (e.g. 3 out of 5)
  final int currentRating;

  /// Callback when a rating is selected. Returns the new rating (index + 1).
  /// Not called if [isReadOnly] is true.
  final Function(int) onRatingSelected;

  /// If true, the widget is for display only and does not accept user input.
  final bool isReadOnly;

  /// The widget to display for an active (filled) rating item.
  final Widget activeImage;

  /// The widget to display for an inactive (empty) rating item.
  final Widget inactiveImage;

  /// Total number of rating items, defaults to 5.
  final int maxRating;

  /// Size of each rating item.
  final double size;

  /// Horizontal padding between items.
  final double itemPadding;

  const CustomRatingWidget({
    super.key,
    required this.currentRating,
    required this.onRatingSelected,
    this.isReadOnly = false,
    required this.activeImage,
    required this.inactiveImage,
    this.maxRating = 5,
    this.size = 30.0,
    this.itemPadding = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        // Determine if this item is active
        final bool isActive = index < currentRating;

        final Widget imageContent = SizedBox(
          width: size,
          height: size,
          child: isActive ? activeImage : inactiveImage,
        );

        if (isReadOnly) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: itemPadding),
            child: imageContent,
          );
        }

        return GestureDetector(
          onTap: () {
            onRatingSelected(index + 1);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: itemPadding),
            child: imageContent,
          ),
        );
      }),
    );
  }
}
