import 'dart:ui';

import 'package:flutter/widgets.dart';

class LogBox extends StatelessWidget {
  const LogBox({required this.content, Key? key}) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Color(0xFFF6F6FE),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          content,
          style: const TextStyle(
            color: Color(0xFF1d084d),
            fontSize: 12,
            height: 1.8,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
      ),
    );
  }
}
