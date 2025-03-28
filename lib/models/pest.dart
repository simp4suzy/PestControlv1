// lib/models/pest.dart
class Pest {
  final String id;
  final String name;
  final String scientificName;
  final String category;
  final String description;
  final String prevention;
  final String treatment;
  final String imagePath;

  Pest({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.category,
    required this.description,
    required this.prevention,
    required this.treatment,
    required this.imagePath,
  });

  factory Pest.fromJson(Map<String, dynamic> json) {
    return Pest(
      id: json['id'],
      name: json['name'],
      scientificName: json['scientificName'],
      category: json['category'],
      description: json['description'],
      prevention: json['prevention'],
      treatment: json['treatment'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'scientificName': scientificName,
      'category': category,
      'description': description,
      'prevention': prevention,
      'treatment': treatment,
      'imagePath': imagePath,
    };
  }
}