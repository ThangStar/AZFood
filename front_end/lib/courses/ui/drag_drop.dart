import 'package:flutter/material.dart';

class DragDropScreen extends StatelessWidget {
  const DragDropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drag drop"),
      ),
      body: Column(
        children: [
          Draggable(
              feedback: Container(
                width: 200,
                height: 200,
                color: Colors.black,
              ), childWhenDragging: 
              const SizedBox.shrink(),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.red,
              )
              ),
          DragTarget(
            builder: (context, candidateData, rejectedData) {
              print(candidateData);
              return ElevatedButton(onPressed: () {}, child: const Text("ABC"));
            },
          )
        ],
      ),
    );
  }
}
