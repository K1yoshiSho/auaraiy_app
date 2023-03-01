import 'package:flutter/material.dart';

class OverlayComponent extends StatelessWidget {
  final int opacityValue;
  const OverlayComponent({
    Key? key, required this.opacityValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(opacityValue, 16, 18, 19),
      ),
    );
  }
}
