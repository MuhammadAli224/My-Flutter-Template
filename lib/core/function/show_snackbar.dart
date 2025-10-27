import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../context/global.dart';
import '../utils/text_style.dart';

class BarContentType {
  final String message;

  final Color? color;

  const BarContentType(this.message, [this.color]);

  static const BarContentType help = BarContentType(
    'help',
    DefaultColors.helpBlue,
  );
  static const BarContentType failure = BarContentType(
    'failure',
    DefaultColors.failureRed,
  );
  static const BarContentType success = BarContentType(
    'success',
    DefaultColors.successGreen,
  );
  static const BarContentType warning = BarContentType(
    'warning',
    DefaultColors.warningYellow,
  );
}

class DefaultColors {
  /// help
  static const Color helpBlue = Color(0xff3282B8);

  /// failure
  static const Color failureRed = Color(0xffc72c41);

  /// success
  static const Color successGreen = Color(0xff2D6A4F);

  /// warning
  static const Color warningYellow = Color(0xffFCA652);
}

enum BarPosition { top, bottom }

void showBar(
    BuildContext context, {
      required String title,
      required String message,
      required BarContentType contentType,
      Duration duration = const Duration(seconds: 3),
      BarPosition position = BarPosition.top,
      bool useSafeArea = true,
    }) {
  final overlay = GlobalContext.navigatorKey.currentState?.overlay;
  if (overlay == null) return;

  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (context) {
      return _AnimatedOverlayBar(
        title: title,
        message: message,
        color: contentType.color ?? Colors.black87,
        duration: duration,
        position: position,
        useSafeArea: useSafeArea,
        onDismissed: () => entry.remove(),
      );
    },
  );

  overlay.insert(entry);
}

class _AnimatedOverlayBar extends StatefulWidget {
  final String title;
  final String message;
  final Color color;
  final Duration duration;
  final BarPosition position;
  final bool useSafeArea;
  final VoidCallback onDismissed;

  const _AnimatedOverlayBar({
    required this.title,
    required this.message,
    required this.color,
    required this.duration,
    required this.position,
    required this.useSafeArea,
    required this.onDismissed,
  });

  @override
  State<_AnimatedOverlayBar> createState() => _AnimatedOverlayBarState();
}

class _AnimatedOverlayBarState extends State<_AnimatedOverlayBar>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 250),
    );

    _slide = Tween(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Future.delayed(widget.duration, _dismiss);
  }

  void _dismiss() async {
    if (!_controller.isAnimating && mounted) {
      await _controller.reverse();
      widget.onDismissed();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final top =
    widget.position == BarPosition.top
        ? (widget.useSafeArea ? padding.top + 20 : 20)
        : null;
    final bottom =
    widget.position == BarPosition.bottom
        ? (widget.useSafeArea ? padding.bottom + 20 : 20)
        : null;
    return Positioned(
      // top: MediaQuery.of(context).padding.top + 20,
      top: top?.toDouble(),
      bottom: bottom?.toDouble(),
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _fade,
          child: GestureDetector(
            onTap: _dismiss,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTextStyle.style22B.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AutoSizeText(
                      widget.message,
                      style: AppTextStyle.style14.copyWith(color: Colors.white),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
