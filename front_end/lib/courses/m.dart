import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ctrl + K Key Event Example'),
        ),
        body: Center(
          child: TextFieldShortcut()
        ),
      ),
    );
  }
}
class TextFieldShortcut extends StatefulWidget {
  const TextFieldShortcut({super.key});

  @override
  State<TextFieldShortcut> createState() => _TextFieldShortcutState();
}

class _TextFieldShortcutState extends State<TextFieldShortcut> {

  late final FocusNode focusNode1, focusNode2;

  @override
  void initState() {
    super.initState();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.arrowUp): () {
          print("1");
        },
        const SingleActivator(LogicalKeyboardKey.arrowDown): () {
          print("2");
        },
      },
      child: Focus(
        child: Column(
          children: <Widget>[
            const Text('Press the up arrow key to add to the counter'),
            const Text('Press the down arrow key to subtract from the counter'),
            Text('count: a'),
          ],
        ),
      ),
    );
  }
}