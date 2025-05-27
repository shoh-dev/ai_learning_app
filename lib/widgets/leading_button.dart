import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

class LeadingButton extends StatelessWidget {
  const LeadingButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
  });

  final String text;
  final IconData? icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonComponent.text(text: text, icon: icon, onPressed: onPressed);
  }
}
