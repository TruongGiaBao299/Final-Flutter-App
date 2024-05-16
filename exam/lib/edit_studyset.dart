import 'package:flutter/material.dart';
import 'library_screen.dart';

class EditStudySet extends StatefulWidget {
  final StudySet studySet;

  const EditStudySet({Key? key, required this.studySet}) : super(key: key);

  @override
  _EditStudySetState createState() => _EditStudySetState();
}

class _EditStudySetState extends State<EditStudySet> {
  List<Map<String, String>> boxes = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.studySet.title;
    _descriptionController.text = widget.studySet.description;
    boxes.addAll(widget.studySet.terms);
  }

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
          'Edit Study Set',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context, {
                  'title': _titleController.text,
                  'description': _descriptionController.text,
                  'terms': boxes,
                });
              }
            },
            child: const Text(
              'Done',
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
                    ...boxes.map((box) {
                      return _buildBox(box);
                    }).toList(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            boxes.add({'term': '', 'definition': ''});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBox(Map<String, String> box) {
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
            initialValue: box['term'],
            onChanged: (value) {
              setState(() {
                box['term'] = value;
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
            initialValue: box['definition'],
            onChanged: (value) {
              setState(() {
                box['definition'] = value;
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
                    boxes.remove(box);
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
