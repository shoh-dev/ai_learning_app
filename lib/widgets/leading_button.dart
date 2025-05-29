import 'package:flutter/material.dart';

class LeadingButton extends StatelessWidget {
  const LeadingButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
  });

  final String text;
  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return TextButton.icon(
        onPressed: onPressed,
        label: Text(text),
        icon: Icon(icon),
      );
    }
    return TextButton(onPressed: onPressed, child: Text(text));
  }
}
