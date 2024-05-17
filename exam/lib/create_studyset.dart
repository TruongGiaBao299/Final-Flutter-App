import 'package:flutter/material.dart';

class CreateStudySet extends StatefulWidget {
  const CreateStudySet({Key? key}) : super(key: key);

  @override
  _CreateStudySetState createState() => _CreateStudySetState();
}

class _CreateStudySetState extends State<CreateStudySet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<Map<String, String>> _terms = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _validateFields() {
    return _formKey.currentState!.validate() &&
        _terms.every((term) =>
            term['term']!.isNotEmpty && term['definition']!.isNotEmpty);
  }

  void _showValidationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please fill all fields.'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _addTerm() {
    setState(() {
      _terms.add({'term': '', 'definition': ''});
    });
  }

  void _saveStudySet() {
    if (_validateFields()) {
      Navigator.pop(context, {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'terms': _terms,
      });
    } else {
      _showValidationError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Create Study Set',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _saveStudySet,
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10.0),
                const Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter title...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Enter description...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                Column(
                  children: [
                    ..._terms.map((term) {
                      return _buildTermField(term);
                    }).toList(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTerm,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTermField(Map<String, String> term) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Term',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5.0),
          TextFormField(
            initialValue: term['term'],
            onChanged: (value) {
              setState(() {
                term['term'] = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter term';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter term...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Definition',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5.0),
          TextFormField(
            initialValue: term['definition'],
            onChanged: (value) {
              setState(() {
                term['definition'] = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter definition';
              }
              return null;
            },
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Enter definition...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _terms.remove(term);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
