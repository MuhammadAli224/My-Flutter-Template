import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WidgetLoading extends StatelessWidget {
  final double width;
  final Color? color;
  final double? height;
  final EdgeInsetsGeometry? padding;

  final double? radius;

  const WidgetLoading({
    super.key,
    this.color,
    required this.width,
    this.height,
    this.radius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: color ?? Colors.black87.withOpacity(0.2),
      child: Container(
        width: width,
        height: height ?? 9.0,
        padding: padding,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius ?? 8.0)),
      ),
    );
  }
}
