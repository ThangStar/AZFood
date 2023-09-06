import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DragDropScreen extends StatelessWidget {
  const DragDropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drag drop"),
      ),
      body: Column(
        children: [
          Draggable(
              feedback: Container(
                width: 200,
                height: 200,
                color: Colors.black,
              ),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.red,
              ), childWhenDragging: 
              SizedBox.shrink()
              ),
          DragTarget(
            builder: (context, candidateData, rejectedData) {
              print(candidateData);
              return ElevatedButton(onPressed: () {}, child: Text("ABC"));
            },
          )
        ],
      ),
    );
  }
}
