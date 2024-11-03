import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundDecorations extends StatelessWidget {
  const BackgroundDecorations({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const Alignment(5, -0.5),
          child: _buildCircleDecoration(context),
        ),
        Align(
          alignment: const Alignment(-5, -0.5),
          child: _buildCircleDecoration(context),
        ),
        Align(
          alignment: const Alignment(0, -1.2),
          child: _buildRectangleDecoration(context),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
          child: Container(color: Colors.transparent),
        ),
      ],
    );
  }

  Widget _buildCircleDecoration(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.deepPurple,
      ),
    );
  }

  Widget _buildRectangleDecoration(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.orange,
      ),
    );
  }
}
