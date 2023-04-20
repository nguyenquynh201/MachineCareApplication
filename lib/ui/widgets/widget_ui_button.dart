import 'package:flutter/material.dart';

class UIIconButton extends StatelessWidget {
  final double? size;
  final Widget child;
  final VoidCallback? onPressed;

  const UIIconButton({
    Key? key,
    this.size,
    this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular((size ?? 48) / 2),
        onTap: onPressed,
        child: Container(
          height: size ?? 48,
          width: size ?? 48,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
