// lib/screens/search_screen.dart
import 'package:flutter/material.dart';
import '../models/pest.dart';
import '../repositories/pest_repository.dart';
import '../widgets/pest_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final PestRepository _repository = PestRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for Pests'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PestSearchDelegate(_repository.getAllPests()), 
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80,
              color: Colors.green.withOpacity(0.5),
            ),
            SizedBox(height: 16),
            Text(
              'Tap the search icon to find pests',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PestSearchDelegate extends SearchDelegate<String> {
  final List<Pest> allPests;
  List<Pest> _searchResults = [];
  bool _hasSearched = false;

  PestSearchDelegate(this.allPests);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          _searchResults = [];
          _hasSearched = false;
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final repository = PestRepository();
    _searchResults = repository.searchPests(query);
    _hasSearched = query.isNotEmpty;
    
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    if (!_hasSearched) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80,
              color: Colors.green.withOpacity(0.5),
            ),
            SizedBox(height: 16),
            Text(
              'Search for pests by name, scientific name, or description',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),
          ],
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No pests found matching "$query"',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final pest = _searchResults[index];
        return PestCard(pest: pest);
      },
    );
  }
}