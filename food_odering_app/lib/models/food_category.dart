/// Food category model
class FoodCategory {
  final String id;
  final String name;
  final String icon;
  final String? image;
  final int itemCount;

  FoodCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.image,
    this.itemCount = 0,
  });

  FoodCategory copyWith({
    String? id,
    String? name,
    String? icon,
    String? image,
    int? itemCount,
  }) {
    return FoodCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      image: image ?? this.image,
      itemCount: itemCount ?? this.itemCount,
    );
  }

  @override
  String toString() => 'FoodCategory(id: $id, name: $name)';
}
