import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name.dart';

class TasksGrid extends StatelessWidget {
  const TasksGrid({Key key, @required this.tasks}) : super(key: key);
  final List<TaskPreset> tasks;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crosAxisSpacing = constraints.maxWidth * 0.05;
        final taskWidth = (constraints.maxWidth - crosAxisSpacing) / 2;
        final aspectRatio = 0.82;
        final taskHeight = taskWidth / aspectRatio;
        final mainAxisSpacing =
            max((constraints.maxHeight - taskHeight * 3) / 2, 0.1);
        final taskLength = tasks.length;

        return GridView.builder(
          padding: EdgeInsets.zero,
          // make grid non scrollable: all items should fit in the available space
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: crosAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: aspectRatio,
          ),
          itemCount: taskLength,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskWithName(
              task: task,
            );
          },
        );
      },
    );
  }
}
