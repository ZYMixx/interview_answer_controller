import 'package:flutter/material.dart';

class MyWidgetButton extends StatefulWidget {
  final String name;
  final VoidCallback onPressed;
  final MaterialColor color;
  const MyWidgetButton(
      {super.key,
      required this.onPressed,
      required this.name,
      required this.color});

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
