import 'package:meta/meta.dart';

class Category {
  int id;
  String categoryName;
  String description;
  String iconPath;
  bool usedForCashFlow = true;
  Category({
    required this.id,
    required this.categoryName,
    required this.description,
    required this.iconPath,
    this.usedForCashFlow = true,
  });
  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Category &&
    runtimeType == other.runtimeType &&
    id == other.id &&
    categoryName == other.categoryName;

  @override
  int get hashCode => id.hashCode ^ categoryName.hashCode ^ iconPath.hashCode;   
}