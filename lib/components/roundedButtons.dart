import 'package:flutter/material.dart';

class roundedButton extends StatelessWidget {
  const roundedButton({
    this.colour,
    this.title,
    required this.onPressedFunction,
    super.key,
  });
  final Color? colour;
  final String? title;
  final VoidCallback onPressedFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour!,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressedFunction,
          minWidth: 200.0,
          height: 42.0,
          child: Text("$title"),
        ),
      ),
    );
  }
}
