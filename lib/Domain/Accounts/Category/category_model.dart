class CategoryModel {
  final String id;
  final String name;
  final CategoryType type;

  CategoryModel({required this.id, required this.name, required this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.toString().split('.').last,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      type: map['type'] == 'income' ? CategoryType.income : CategoryType.expense,
    );
  }
}

enum CategoryType {
  income,
  expense,
}