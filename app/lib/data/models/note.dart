class Note {
  final String id;
  final String title;
  final String content;
  final String? summary; // Can be null if not summarized yet
  final DateTime createdAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.summary,
    required this.createdAt,
  });

  // Convert a Note object into a Map object (to save as JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'summary': summary,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert a Map object into a Note object (to read from JSON)
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      summary: json['summary'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
