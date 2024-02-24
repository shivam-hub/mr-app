import 'package:flutter/material.dart';

Future<T?> showTextDialog<T>(BuildContext context,
        {required String title, required String value}) =>
    showDialog<T>(
        context: context,
        builder: (context) => TextDialogWidget(title: title, value: value));

class TextDialogWidget extends StatefulWidget {
  final String title;
  final String value;

  const TextDialogWidget({super.key, required this.title, required this.value});

  @override
  State<TextDialogWidget> createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(_controller.text),
            child: const Text('Done'))
      ],
    );
  }
}
