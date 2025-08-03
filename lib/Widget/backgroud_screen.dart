import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/background.svg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
   SafeArea(child: child)
      ],
    );
  }
}
