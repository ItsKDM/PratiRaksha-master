import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final Widget child;
  final double size;
  final double borderWidth;

  CustomButtonWidget({
    @required this.child,
    @required this.borderWidth = 2,
    @required this.size,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(200),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0XAA92aeff),
            blurRadius: 10,
            offset: Offset(5, 5),
            spreadRadius: 3,
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 5,
            offset: Offset(-5, -5),
            spreadRadius: 3,
          ),
        ],
        gradient: RadialGradient(
          colors: [
            Color(0XFFe5eefc),
            Color(0XFFe5eefc),
            Color(0XFFe5eefc),
            Colors.white,
          ],
        ),
      ),
      child: child,
    );
  }
}
