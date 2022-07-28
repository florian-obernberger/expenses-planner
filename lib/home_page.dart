import 'package:expenses_planner/data/expenses_item.dart';
import 'package:expenses_planner/services/hive_manager.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ColorScheme colorScheme;
  late TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    colorScheme = Theme.of(context).colorScheme;
    textTheme = Theme.of(context).textTheme;

    return Scaffold(
      floatingActionButton: buildFab(),
      appBar: buildAppBar(),
      body: ValueListenableBuilder(
        valueListenable:
            HiveManager.getBox<ExpensesItem>(Boxes.items).listenable(),
        builder: (context, value, child) {
          return ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              for (var item in value.values)
                ExpensesItemTile(item)
            ],
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Expenses Planner"),
      centerTitle: true,
    );
  }

  FloatingActionButton buildFab() {
    return FloatingActionButton.extended(
      label: const Text("Add entry"),
      icon: const Icon(Icons.add_outlined),
      onPressed: newEntry,
    );
  }

  void newEntry() {}
}
