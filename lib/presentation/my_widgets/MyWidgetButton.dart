import 'package:flutter/material.dart';

class MyWidgetButton extends StatefulWidget {
  const MyWidgetButton(
      {super.key,
      required this.onPressed,
      required this.name,
      required this.color});
  final String name;
  final MaterialColor color;
  final VoidCallback onPressed;

  @override
  State<MyWidgetButton> createState() => _MyWidgetButtonState();
}

class _MyWidgetButtonState extends State<MyWidgetButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(
            const Size.fromHeight(60),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(widget.color),
        ),
        child: Text(
          widget.name,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
