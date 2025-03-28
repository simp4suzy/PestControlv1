import 'package:pest_controlv1/screens/exit_screen.dart';
import 'package:pest_controlv1/screens/references_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'search_screen.dart';
import 'category_screen.dart';
import 'guides_screen.dart';
import 'feedback_screen.dart';
import '../utils/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Pestify'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode 
              ? [Colors.grey[850]!, Colors.grey[900]!] 
              : [Colors.green[50]!, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header section
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Welcome to Pestify',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Your Smart Solution for a Pest-Free Life! Effortlessly track, prevent, and eliminate pests with ease.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                            fontStyle: FontStyle.italic,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Menu options with images/GIFs
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final List<Map<String, dynamic>> menuItems = [
                      {
                        'image': 'assets/search_pest.jpg',
                        'title': 'Search for Pests',
                        'screen': SearchScreen(),
                      },
                      {
                        'image': 'assets/browse_categories.jpg',
                        'title': 'Browse Categories',
                        'screen': CategoryScreen(),
                      },
                      {
                        'image': 'assets/prevention_technique.png',
                        'title': 'Prevention & Treatment',
                        'screen': GuidesScreen(),
                      },
                      {
                        'image': 'assets/userfeedback_notes.jpg',
                        'title': 'User Feedback & Notes',
                        'screen': FeedbackScreen(),
                      },
                      {
                        'image': 'assets/references.png',
                        'title': 'References',
                        'screen': ReferencesScreen(),
                      },
                      {
                        'image': 'assets/exit.png',
                        'title': 'Exit Application',
                        'screen': ExitScreen(),
                      },
                    ];
                    return _buildMenuCard(
                      context,
                      menuItems[index]['image'],
                      menuItems[index]['title'],
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => menuItems[index]['screen']),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String imagePath,
    String title,
    VoidCallback onTap,
  ) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      isDarkMode ? Colors.black.withOpacity(0.7) : Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}