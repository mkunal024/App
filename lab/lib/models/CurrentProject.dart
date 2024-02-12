class CurrentProject {
  final int id;
  final String title;
  final String description;

  CurrentProject({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory CurrentProject.fromMap(Map<String, dynamic> map) {
    return CurrentProject(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}

