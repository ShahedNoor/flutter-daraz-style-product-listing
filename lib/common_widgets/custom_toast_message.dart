import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';
import '../helpers/navigation_service.dart';

void customToastMessage(String title, String description) {
  final overlay = NavigationService.navigatorKey.currentState?.overlay;
  if (overlay == null) return;

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => _TopToastWidget(
      title: title,
      description: description,
      onDismiss: () {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
        }
      },
    ),
  );

  overlay.insert(overlayEntry);
}

class _TopToastWidget extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback onDismiss;

  const _TopToastWidget({
    required this.title,
    required this.description,
    required this.onDismiss,
  });

  @override
  State<_TopToastWidget> createState() => _TopToastWidgetState();
}

class _TopToastWidgetState extends State<_TopToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
          milliseconds: 600), // Slightly slower for smooth iOS feel
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack, // Bouncy effect
      reverseCurve: Curves.easeIn,
    ));

    _controller.forward();

    // Auto dismiss after 3 seconds
    _timer = Timer(const Duration(seconds: 3), () {
      _dismiss();
    });
  }

  void _dismiss() {
    if (mounted) {
      _controller.reverse().then((_) {
        widget.onDismiss();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: SlideTransition(
            position: _offsetAnimation,
            child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.up,
              onDismissed: (_) {
                widget.onDismiss();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: widget.title.toLowerCase() == 'error'
                        ? AppColors.cE53935
                        : AppColors.c111827, // dark gray for regular toast
                    borderRadius: BorderRadius.circular(4.r), // flatter design
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.c000000.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      if (widget.title.toLowerCase() == 'error')
                        Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: Icon(Icons.error_outline,
                              color: AppColors.cFFFFFF, size: 24.sp),
                        ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.title.isNotEmpty)
                              Text(widget.title,
                                  style: TextFontStyle
                                      .textStyle14c6B7280Inter400
                                      .copyWith(
                                    color: AppColors.cFFFFFF,
                                    fontWeight: FontWeight.w600,
                                  )),
                            if (widget.title.isNotEmpty) SizedBox(height: 4.h),
                            Text(
                              widget.description,
                              style: TextFontStyle.textStyle14c6B7280Inter400
                                  .copyWith(
                                color: AppColors.cFFFFFF,
                                fontSize: 13.sp,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
