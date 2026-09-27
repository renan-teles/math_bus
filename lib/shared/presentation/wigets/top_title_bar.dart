import 'package:flutter/material.dart';

class TopTitleBar extends StatelessWidget {
  final _assetName = 'assets/images/math_bus.png';
  final String _title;

  const TopTitleBar({super.key, required this._title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(_assetName, width: 36, height: 36),
        const SizedBox(width: 8),
        Text(_title),
      ],
    );
  }
}
