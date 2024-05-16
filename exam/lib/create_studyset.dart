import 'package:flutter/material.dart';

class CreateStudySet extends StatefulWidget {
  const CreateStudySet({Key? key}) : super(key: key);

  @override
  _CreateStudySetState createState() => _CreateStudySetState();
}

class _CreateStudySetState extends State<CreateStudySet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<Map<String, String>> _terms = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Study Set'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            Text(
              'Terms',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _terms.length,
                itemBuilder: (context, index) {
                  return TermField(
                    term: _terms[index]['term']!,
                    definition: _terms[index]['definition']!,
                    onTermChanged: (value) {
                      setState(() {
                        _terms[index]['term'] = value;
                      });
                    },
                    onDefinitionChanged: (value) {
                      setState(() {
                        _terms[index]['definition'] = value;
                      });
                    },
                    onDelete: () {
                      setState(() {
                        _terms.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _terms.add({'term': '', 'definition': ''});
                  });
                },
                child: Text('Add Term'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Validate form
                  if (_titleController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty &&
                      _terms.every((term) =>
                          term['term']!.isNotEmpty &&
                          term['definition']!.isNotEmpty)) {
                    // Return study set data
                    Navigator.pop(context, {
                      'title': _titleController.text,
                      'description': _descriptionController.text,
                      'terms': _terms,
                    });
                  } else {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill all fields.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TermField extends StatelessWidget {
  final String term;
  final String definition;
  final ValueChanged<String> onTermChanged;
  final ValueChanged<String> onDefinitionChanged;
  final VoidCallback onDelete;

  const TermField({
    Key? key,
    required this.term,
    required this.definition,
    required this.onTermChanged,
    required this.onDefinitionChanged,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: term,
          onChanged: onTermChanged,
          decoration: InputDecoration(labelText: 'Term'),
        ),
        SizedBox(height: 10),
        TextFormField(
          initialValue: definition,
          onChanged: onDefinitionChanged,
          decoration: InputDecoration(labelText: 'Definition'),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: onDelete,
            icon: Icon(Icons.delete),
            label: Text('Delete'),
          ),
        ),
        Divider(),
      ],
    );
  }
}
