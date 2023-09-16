import 'package:first_app/core/utiles/app_colors.dart';
import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  MyElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final defaultBackgroundColor = AppColors.primary;
    final buttonBackgroundColor = backgroundColor ?? defaultBackgroundColor;

    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
        backgroundColor: MaterialStateProperty.all(buttonBackgroundColor),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}