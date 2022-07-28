import 'package:expenses_planner/data/expenses_item.dart';
import 'package:expenses_planner/services/nullable.dart';
import 'package:flutter/material.dart';

class ExpensesItemTile extends StatelessWidget {
  const ExpensesItemTile(this.item, {super.key});
  final ExpensesItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ListTile(
        title: Text(item.title),
        subtitle: nullableFunction<Text, String>((v) => Text(v), item.subTitle),
        trailing: CircleAvatar(child: Text(item.value.toString())),
      ),
    );
  }
}
