import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _suggestedPestController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  // Lists to store notes and suggestions
  List<Map<String, String>> userNotes = [];
  List<Map<String, String>> userSuggestions = [];
  
  // If you want to implement sorting functionality, add this:
  bool reversed = false; // Add this line if you want sorting functionality

  // Email configuration (replace with your actual email)
  static const String OWNER_EMAIL = 'dreadnoughtalmighty6969@gmail.com';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Load saved data when the screen initializes
    _loadSavedData();
  }

  // Load saved data from SharedPreferences
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Load notes
      final notesJson = prefs.getString('user_notes') ?? '[]';
      userNotes = (json.decode(notesJson) as List)
          .map((item) => Map<String, String>.from(item))
          .toList();
      
      // Load suggestions
      final suggestionsJson = prefs.getString('user_suggestions') ?? '[]';
      userSuggestions = (json.decode(suggestionsJson) as List)
          .map((item) => Map<String, String>.from(item))
          .toList();
    });
  }

  // Save notes to SharedPreferences
  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_notes', json.encode(userNotes));
  }

  // Save suggestions to SharedPreferences
  Future<void> _saveSuggestions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_suggestions', json.encode(userSuggestions));
  }

  // Send email for pest suggestion
  Future<void> _sendPestSuggestionEmail(String pestName, String description) async {
    final Email email = Email(
      body: '''
      New Pest Suggestion:
      
      Pest Name: $pestName
      
      Description: $description
      
      Suggestion Date: ${DateTime.now()}
      ''',
      subject: 'New Pest Suggestion: $pestName',
      recipients: [OWNER_EMAIL],
    );

    try {
      await FlutterEmailSender.send(email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Suggestion sent to app owner successfully!')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send suggestion: $error')),
      );
    }
  }

  // Add a new note
  void _addNote() {
    if (_noteController.text.trim().isNotEmpty) {
      setState(() {
        userNotes.add({
          'note': _noteController.text,
          'date': DateTime.now().toString(),
        });
      });
      
      // Save notes immediately
      _saveNotes();
      
      // Clear the text field
      _noteController.clear();
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Note saved successfully!')),
      );
    }
  }

  // Add a new pest suggestion
  void _addSuggestion() {
    if (_suggestedPestController.text.trim().isNotEmpty) {
      // Create suggestion entry
      final suggestion = {
        'name': _suggestedPestController.text,
        'description': _descriptionController.text,
        'date': DateTime.now().toString(),
      };

      setState(() {
        userSuggestions.add(suggestion);
      });
      
      // Save suggestions
      _saveSuggestions();
      
      // Send email to app owner
      _sendPestSuggestionEmail(
        suggestion['name']!, 
        suggestion['description']!
      );
      
      // Clear text fields
      _suggestedPestController.clear();
      _descriptionController.clear();
    }
  }

  // Delete a note
  void _deleteNote(int index) {
    setState(() {
      userNotes.removeAt(index);
    });
    _saveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Feedback & Notes'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Personal Notes'),
            Tab(text: 'Suggest a Pest'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Personal Notes Tab
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    hintText: 'Enter your notes about pest experiences...',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.green),
                      onPressed: _addNote,
                    ),
                  ),
                  maxLines: 3,
                ),
              ),
              Expanded(
                child: userNotes.isEmpty
                    ? Center(
                        child: Text(
                          'No notes yet. Add your first note!',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: userNotes.length,
                        itemBuilder: (context, index) {
                          // If you want to implement sorting, use this:
                          // final note = userNotes[reversed ? userNotes.length - 1 - index : index];
                          
                          // Otherwise, just use this:
                          final note = userNotes[index];
                          final date = DateTime.parse(note['date']!);
                          final formattedDate =
                              '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
                          
                          return Card(
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                              title: Text(note['note']!),
                              subtitle: Text('Added on $formattedDate'),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteNote(index),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          
          // Suggest a Pest Tab
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Suggest a New Pest to Add to the Library',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _suggestedPestController,
                  decoration: InputDecoration(
                    labelText: 'Pest Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Pest Description (Optional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addSuggestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    minimumSize: Size(double.infinity, 0),
                  ),
                  child: Text('Submit Suggestion'),
                ),
                SizedBox(height: 24),
                Text(
                  'Your Previous Suggestions:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                userSuggestions.isEmpty
                    ? Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'No suggestions yet.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : Column(
                        children: userSuggestions.map((suggestion) {
                          final date = DateTime.parse(suggestion['date']!);
                          final formattedDate =
                              '${date.day}/${date.month}/${date.year}';
                          
                          return Card(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    suggestion['name']!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  if (suggestion['description']!.isNotEmpty)
                                    Text(suggestion['description']!),
                                  SizedBox(height: 4),
                                  Text(
                                    'Suggested on $formattedDate',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _noteController.dispose();
    _suggestedPestController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}