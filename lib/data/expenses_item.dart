import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'expenses_item.g.dart';

@HiveType(typeId: 0)
class ExpensesItem extends Equatable {
  const ExpensesItem({
    required this.title,
    this.subTitle,
    required this.value,
  });

  @HiveField(0)
  final String title;
  @HiveField(1)
  final String? subTitle;
  @HiveField(2)
  final double value;

  @override
  List<dynamic> get props => [title, subTitle, value];
}
