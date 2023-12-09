class CategoryResponse {
  final String status;
  final String message;
  final List<Category> data;

  CategoryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList(),
    );
  }
}

class Category {
  final String id;
  final String name;
  final String icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }
}
