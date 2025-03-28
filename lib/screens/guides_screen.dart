// lib/screens/guides_screen.dart
import 'package:flutter/material.dart';

class GuidesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> preventionGuides = [
    {
      'title': 'Maintaining Sanitation',
      'icon': Icons.cleaning_services,
      'description': 'Keep living areas clean to remove food sources and harborage for pests.',
      'steps': [
        'Clean up food and drink spills immediately',
        'Store food in sealed containers',
        'Take out garbage regularly',
        'Keep indoor and outdoor areas free of clutter',
        'Regularly vacuum and clean floors and furniture'
      ]
    },
    {
      'title': 'Physical Barriers',
      'icon': Icons.security,
      'description': 'Install physical barriers to prevent pests from entering structures.',
      'steps': [
        'Seal cracks and crevices in walls and foundations',
        'Install door sweeps on exterior doors',
        'Use window screens with no tears or holes',
        'Caulk around pipes and utility entries',
        'Use weather stripping around doors and windows'
      ]
    },
    {
      'title': 'Landscaping Techniques',
      'icon': Icons.grass,
      'description': 'Maintain your yard to discourage pest habitation.',
      'steps': [
        'Keep grass short and well-maintained',
        'Trim tree branches away from house structures',
        'Remove standing water from yard',
        'Keep firewood stacked away from buildings',
        'Use gravel or stone barriers around foundations'
      ]
    },
  ];

  final List<Map<String, dynamic>> treatmentGuides = [
    {
      'title': 'Chemical Control',
      'icon': Icons.science,
      'description': 'Using chemicals to control pest populations when necessary.',
      'steps': [
        'Always read and follow label instructions',
        'Use the least toxic product that will be effective',
        'Apply products only where pests are likely to be found',
        'Wear appropriate protective equipment',
        'Store chemicals safely away from children and pets'
      ]
    },
    {
      'title': 'Biological Control',
      'icon': Icons.pets,
      'description': 'Using natural predators or pathogens to control pest populations.',
      'steps': [
        'Introduce beneficial insects like ladybugs for aphid control',
        'Use nematodes to control soil-dwelling pests',
        'Consider microbial pesticides for specific pest issues',
        'Plant companion plants that repel common pests',
        'Create habitats for natural pest predators like birds'
      ]
    },
    {
      'title': 'Mechanical Control',
      'icon': Icons.build,
      'description': 'Using physical methods to trap, remove, or kill pests.',
      'steps': [
        'Use traps appropriate for the target pest',
        'Consider barriers such as sticky tape or diatomaceous earth',
        'Remove pests by hand when feasible',
        'Prune infected plant parts',
        'Use physical disruption like tilling for soil pests'
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prevention & Treatment Guides'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Prevention Techniques', Icons.shield),
              SizedBox(height: 16),
              ...preventionGuides.map((guide) => _buildGuideCard(guide)),
              SizedBox(height: 32),
              _buildSectionHeader('Treatment Methods', Icons.healing),
              SizedBox(height: 16),
              ...treatmentGuides.map((guide) => _buildGuideCard(guide)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideCard(Map<String, dynamic> guide) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green[100],
          child: Icon(
            guide['icon'],
            color: Colors.green[800],
          ),
        ),
        title: Text(
          guide['title'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
        ),
        subtitle: Text(
          guide['description'],
          style: TextStyle(fontSize: 12),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Steps to Follow:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                ...List.generate(
                  guide['steps'].length,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}. ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(guide['steps'][index]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}