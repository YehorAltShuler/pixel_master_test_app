import 'package:flutter/material.dart';

class CustomListWheel extends StatefulWidget {
  const CustomListWheel(
      {super.key,
      required this.children,
      required this.initialItem,
      this.onSelectedItemChanged,
      this.offAxisFraction});

  final List<Widget> children;
  final int initialItem;
  final void Function(int)? onSelectedItemChanged;
  final double? offAxisFraction;

  @override
  State<CustomListWheel> createState() => _CustomListWheelState();
}

class _CustomListWheelState extends State<CustomListWheel> {
  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      controller: FixedExtentScrollController(initialItem: widget.initialItem),
      useMagnifier: true,
      magnification: 1.5,
      physics: const FixedExtentScrollPhysics(),
      itemExtent: 35,
      diameterRatio: 1,
      offAxisFraction: widget.offAxisFraction ?? 0,
      onSelectedItemChanged: widget.onSelectedItemChanged,
      children: widget.children,
    );
  }
}
