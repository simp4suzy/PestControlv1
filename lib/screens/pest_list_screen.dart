import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/pest.dart';
import '../repositories/pest_repository.dart';
import '../widgets/pest_card.dart';

class PestListScreen extends StatelessWidget {
  final Category category;
  final PestRepository _repository = PestRepository();

  PestListScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    List<Pest> pests = _repository.getPestsByCategory(category.id);

    return Scaffold(
      appBar: AppBar(title: Text('${category.name} Pests')),
      body: pests.isEmpty
          ? Center(child: Text('No pests found in this category.'))
          : ListView.builder(
              itemCount: pests.length,
              itemBuilder: (context, index) {
                return PestCard(pest: pests[index]);
              },
            ),
    );
  }
}