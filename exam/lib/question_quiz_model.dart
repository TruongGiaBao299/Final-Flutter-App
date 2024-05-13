class Questions {
  final String id;
  final String title;
  final Map<String, bool> options;

  Questions({required this.id, required this.title, required this.options});

  String toString() {
    return 'Question(id: ${id}, title: ${title}, options: $options)';
  }
}
