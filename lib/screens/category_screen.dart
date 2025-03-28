import 'package:flutter/material.dart';
import '../models/category.dart';
import '../repositories/pest_repository.dart';
import 'pest_list_screen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PestRepository _repository = PestRepository();
  late List<Category> categories;

  @override
  void initState() {
    super.initState();
    categories = _repository.getAllCategories();
  }

  void _navigateToCategory(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PestListScreen(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Browse Pest Categories')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return GestureDetector(
            onTap: () => _navigateToCategory(category),
            child: Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Image.asset(
                  category.iconPath,
                  height: 40,
                  width: 40,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.category, size: 40),
                ),
                title: Text(
                  category.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(category.description),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
    );
  }
}