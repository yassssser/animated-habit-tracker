import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_page.dart';
import 'package:hive/hive.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataStore = HiveDataStore();
    return ValueListenableBuilder(
      valueListenable: dataStore.tasksListenable(),
      builder: (_, Box<Task> box, __) => TasksGridPage(
        tasks: box.values.toList(),
      ),
    );
  }
}
