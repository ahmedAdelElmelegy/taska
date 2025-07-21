import 'package:flutter/material.dart';
import 'package:taska/features/on_boarding/widgets/dots.dart';

class DotsList extends StatefulWidget {
  final int currentIndex;
  const DotsList({super.key, required this.currentIndex});

  @override
  State<DotsList> createState() => _DotsListState();
}

class _DotsListState extends State<DotsList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Dots(isActive: index == widget.currentIndex),
        ),
      ),
    );
  }
}
