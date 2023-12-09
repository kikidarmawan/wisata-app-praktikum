import 'package:flutter/material.dart';

class ShimmerDark extends StatefulWidget {
  final double? height;
  final double? width;
  ShimmerDark({Key? key, this.height, this.width}) : super(key: key);

  @override
  _ShimmerState createState() => _ShimmerState();
}

class _ShimmerState extends State<ShimmerDark> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      height: widget.height,
      width: widget.width,
    );
  }
}
