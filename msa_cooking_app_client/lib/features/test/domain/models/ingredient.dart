class Ingredient {
  final String id;
  final String name;
  final double caloriesPer100Grams;

  Ingredient({
    required this.id,
    required this.name,
    required this.caloriesPer100Grams,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      caloriesPer100Grams: (json['caloriesPer100Grams'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'caloriesPer100Grams': caloriesPer100Grams,
    };
  }
}